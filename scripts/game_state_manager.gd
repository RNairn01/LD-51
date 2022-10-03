extends Node

onready var scene_manager = get_node("/root/SceneManager")
onready var music_controller = get_node("/root/Node2D/MusicController")

var is_tutorial = false
var lives_remaining = 3
var is_game_over = false
var game_can_end = true
var is_game_paused = false
var can_unpause = true
var game_not_won = true
var current_score = 2
var winning_score = 5
var in_endless_mode = false


signal game_pause 
signal game_unpause
signal life_lost
signal score_increase
signal play_dialogue


func _ready():
	scene_manager.final_score = 0
	is_tutorial = scene_manager.tutorial_selected
	yield(self.get_parent(), "ready")
	if is_tutorial:
		_play_scene(2)

func _process(delta):
	if not is_game_over and game_can_end and lives_remaining < 1:
		game_over()
	elif current_score >= winning_score and game_not_won:
		game_win()

	if Input.is_action_just_pressed("pause") and is_game_paused and can_unpause:
		print("unpause")
		is_game_paused = false
		emit_signal("game_unpause")
	elif Input.is_action_just_pressed("pause") and not is_game_paused:
		print("pause")
		is_game_paused = true
		emit_signal("game_pause")

func game_over():
	game_can_end = false
	can_unpause = false
	is_game_over = true
	music_controller.stopCurrentSound()
	_play_scene(1)
	emit_signal("game_pause")

func game_win():
	game_not_won = false
	_play_scene(0)
	emit_signal("game_pause")

func increase_score():
	current_score += 1
	emit_signal("score_increase", current_score)

func _lose_life():
	lives_remaining -= 1
	emit_signal("life_lost", lives_remaining)

func _play_scene(scene_n):
	emit_signal("game_pause")
	is_game_paused = true
	can_unpause = false
	emit_signal("play_dialogue", scene_n)

func start_endless_mode():
	self.in_endless_mode = true

func high_score_screen():
	scene_manager.final_score = self.current_score
	scene_manager._load_high_score_scene()
	
func is_tutorial():
	return is_tutorial
	

