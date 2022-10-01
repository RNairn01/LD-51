extends "res://scripts/snail_controller.gd"

onready var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	._ready()

func _on_tick():
	_fuck_you_i_do_what_i_want()
	._on_tick()
	
	
func _fuck_you_i_do_what_i_want():
	if rng.randf() <= 0.05:
		var speech_bubble = load("res://scenes/rebel_speech_bubble.tscn").instance()
		add_child(speech_bubble)
		
		var new_direction = rng.randi_range(1, 4)
		if new_direction == 1:
			self.snail_direction = Vector2.UP
		elif new_direction == 2:
			self.snail_direction = Vector2.RIGHT
		elif new_direction == 3:
			self.snail_direction = Vector2.DOWN
		elif new_direction == 4:#
			self.snail_direction = Vector2.LEFT
