extends Sprite

#This is not a very good dialogue system. I am tired.

onready var game_state_manager = get_node("/root/Node2D/GameStateManager")
onready var sfx_controller = get_node("/root/Node2D/SfxController")
onready var base_state = preload("res://assets/sprites/mr_snailsworth.png")
onready var talk_state = preload("res://assets/sprites/mr_snailsworth_talking.png")
onready var speech_anchor = $Anchor
onready var text_label = $Anchor/TextLabel
onready var text_bubble = $Anchor/SpeechBubble
onready var tween = $Anchor/Tween
onready var next_button = $Anchor/NextButton
onready var endless_mode_button = $Anchor/EndlessModeButton
onready var dialogue_sound_player = get_node("DialogueSoundPlayer")

var tutorial_dialogue = [
	[
		["Tutorial00", "Ah yes, the new Snail Traffic Control officer! I'm Mr. Snailsworth, the manager of this department."],
		["Tutorial01", "Let's get you started right away. Let's take a look at the Snail Traffic Control Board."],
		["Tutorial02", "Oh! Those two snails are about to crash! Set a control point by clicking and dragging on a square to let one of them know to change direction!"],
		["Tutorial03", "Once they hit a control point, that snail will go off in the other direction. We would be in big trouble if two of them collided!"],
		["Tutorial04", "You can right click on any control point you have placed to remove it. Isn't that handy?"],
		["Tutorial05", "That's really all there is to it. Just keep them in a nice, safe holding pattern. Keep in mind, more will be coming soon! Just call me if you get into trouble."]
	],
	[
		["Tutorial10", "Oh! That's a fast one! Don't worry, theyre similar to the others, just plan your control arrows ahead and everything will be fine."]
	],
	[
		["Tutorial20", "Oof! Keep an eye out for those Heavy Duty snails. Make sure to avoid hitting two arrows at the same time, or they tend to get confused and explode!"]
	],
	[
		["Tutorial30", "Wha..? I don't like the looks of that one. I've heard of these sorts, coming in, changing direction without so much as a by-your-leave from STC. Best to keep them away from the others, if you can."]
	]
]

var fail_dialogue = [
	["Fail0", "NO! Get off the console! Do you have any idea how much damage you've caused? Not to mention the loss of life! This is a catastrophe!"],
	["Fail1", "Get out of here before I call the police! You're fired! And you can expect a call from our legal department!"]
]

var win_dialogue = [
	["Win0", "Working hard, I see! Tremendous work for your first day on the job! I think you have a bright future ahead of you here."],
	["Win1", "You should head home now, not licensed for multiple shifts in a row."]
]

var current_dialogue = tutorial_dialogue[0]

func _ready():
	game_state_manager.connect("play_dialogue", self, "_play_dialogue")
	speech_anchor.visible = false

func set_base_state():
	self.texture = base_state

func set_talk_state():
	self.texture = talk_state

func close_speech_bubble():
	dialogue_sound_player.stop() # Stop any dialogue sounds that were ongoing
	self.set_base_state()
	speech_anchor.visible = false

	if game_state_manager.is_game_over:
		game_state_manager.high_score_screen()
	elif game_state_manager.game_not_won or (game_state_manager.in_endless_mode and not game_state_manager.is_game_over):
		game_state_manager.can_unpause = true
		game_state_manager.is_game_paused = false
		game_state_manager.emit_signal("game_unpause")
	else:
		game_state_manager.high_score_screen()


func _play_dialogue(dialogue_number):
	match(dialogue_number):
		0:
			current_dialogue = win_dialogue
		1:
			current_dialogue = fail_dialogue
		2:
			current_dialogue = tutorial_dialogue[0]
		3:
			current_dialogue = tutorial_dialogue[1]
		4:
			current_dialogue = tutorial_dialogue[2]
		5:
			current_dialogue = tutorial_dialogue[3]

	display_text(current_dialogue[0][0], current_dialogue[0][1])

func display_text(id, text):
	endless_mode_button.visible = false
	endless_mode_button.disabled = true
	next_button.visible = false
	next_button.disabled = true
	self.set_talk_state()
	speech_anchor.visible = true
	text_label.text = text
	var duration = text_label.text.length() * 0.02
	tween.remove_all()
	tween.interpolate_property(text_label, "percent_visible", 0, 1, duration)
	tween.start()
	dialogue_sound_player.playTrack(id) # Stop current dialogue track and play the one for this text
	
	next_button.visible = true
	next_button.disabled = false
	if current_dialogue.size() <= 1 and not game_state_manager.game_not_won and not game_state_manager.is_game_over:
		endless_mode_button.visible = true
		endless_mode_button.disabled = false

func _on_next_button_press():
	sfx_controller.play_sound("click")
	current_dialogue.pop_front()
	if current_dialogue.size() >= 1:
		display_text(current_dialogue[0][0], current_dialogue[0][1])
	else:
		self.close_speech_bubble()

func _on_endless_mode_press():
	sfx_controller.play_sound("click")
	game_state_manager.start_endless_mode()
	self.close_speech_bubble()
