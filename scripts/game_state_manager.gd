extends Node

var is_tutorial = true
var lives_remaining = 3
var is_game_over = false
var is_game_paused = false

signal game_pause 
signal game_unpause


func _ready():
	pass

func _process(delta):
	if not is_game_over and lives_remaining < 1:
		print("game over")

	if Input.is_action_just_pressed("pause") and is_game_paused:
		print("unpause")
		is_game_paused = false
		emit_signal("game_unpause")
	elif Input.is_action_just_pressed("pause") and not is_game_paused:
		print("pause")
		is_game_paused = true
		emit_signal("game_pause")
