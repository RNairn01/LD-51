extends Control

onready var scene_manager = get_node("/root/SceneManager")
onready var tutorial_toggle = $Layer6/CheckBoxBackground/Button
onready var play_button = $Layer6/PlayButton
onready var button_sound = $ButtonClickPlayer


func _ready():
	self.set_tutorial_state()
	tutorial_toggle.connect("button_down", scene_manager, "_toggle_tutorial")
	play_button.connect("button_down", scene_manager, "_on_click_play")

	tutorial_toggle.connect("button_down", self, "_play_sound")
	play_button.connect("button_down", self, "_play_sound")

func _play_sound():
	button_sound.play()

func set_tutorial_state():
	if scene_manager.tutorial_selected:
		tutorial_toggle.pressed = true
	else: 
		tutorial_toggle.pressed = false
