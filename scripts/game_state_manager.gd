extends Node

var is_tutorial = true
var lives_remaining = 3
var is_game_over = false
var game_can_end = true
var is_game_paused = false
var can_unpause = true
var current_score = 2

signal game_pause 
signal game_unpause
signal life_lost
signal score_increase
signal play_dialogue


func _ready():
	yield(self.get_parent(), "ready")
	_play_scene(2)
	pass

func _process(delta):
	if not is_game_over and game_can_end and lives_remaining < 1:
		game_can_end = false
		can_unpause = false
		is_game_over = true
		emit_signal("game_pause")
		print("game over")

	if Input.is_action_just_pressed("pause") and is_game_paused and can_unpause:
		print("unpause")
		is_game_paused = false
		emit_signal("game_unpause")
	elif Input.is_action_just_pressed("pause") and not is_game_paused:
		print("pause")
		is_game_paused = true
		emit_signal("game_pause")

func increase_score():
	current_score += 1
	emit_signal("score_increase", current_score)

func _lose_life():
	lives_remaining -= 1
	emit_signal("life_lost", lives_remaining)

func _play_scene(scene_n):
	print("play")
	emit_signal("game_pause")
	is_game_paused = true
	can_unpause = false
	emit_signal("play_dialogue", scene_n)

