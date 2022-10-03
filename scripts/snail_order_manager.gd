extends Node2D

var normal_snail = preload("res://scenes/snails/snail_normal.tscn")
var speedy_snail = preload("res://scenes/snails/snail_speedy.tscn")
var big_snail = preload("res://scenes/snails/snail_big.tscn")
var rebel_snail = preload("res://scenes/snails/snail_rebel.tscn")
onready var timer_label = get_node("/root/Node2D/UI/SidePanel/TimerLabel")
onready var game_state_manager = get_node("/root/Node2D/GameStateManager")
onready var next = snail_order.pop_front().instance()
onready var landing_indicator = $LandingIndicator
onready var animation_player = $AnimationPlayer
onready var game_parent = get_node("/root/Node2D")
onready var music_controller = get_node("/root/Node2D/MusicController")

var rng = RandomNumberGenerator.new()

signal next_snail
signal play_tutorial

var valid_spawn_positions: PoolVector2Array = []
var next_spawn_pos: Vector2
var snail_order = [normal_snail, normal_snail, normal_snail]
var tutorial_snail_order = [
	normal_snail, normal_snail, normal_snail, speedy_snail, normal_snail,
	normal_snail, big_snail, normal_snail, speedy_snail, normal_snail,
	normal_snail, normal_snail, normal_snail, big_snail, normal_snail,
	normal_snail, speedy_snail, rebel_snail, normal_snail, big_snail
]

var speedy_not_seen = true
var big_not_seen = true
var rebel_not_seen = true

func _enter_tree():
	rng.randomize()
	populate_spawn_locations()
	#Set first spawn location
	next_spawn_pos = get_next_spawn_pos()

func _ready():
	game_state_manager.connect("game_pause", self, "_on_pause")
	game_state_manager.connect("game_unpause", self, "_on_unpause")
	self.connect("play_tutorial", game_state_manager, "_play_scene")
	timer_label.connect("timeout_label", self, "_on_timeout")
	animation_player.play("fade_in")
	landing_indicator.position = next_spawn_pos
	landing_indicator.visible = true

	if game_state_manager.is_tutorial():
		snail_order = tutorial_snail_order.duplicate(true)
	if snail_order.size() < 5:
		generate_more_snails()

func _on_timeout():
	#Spawn snail
	next.position = next_spawn_pos
	next.snail_direction = get_snail_initial_direction()
	check_music_and_play_tutorial(next.name)

	game_parent.add_child(next)

	#Increase score
	game_state_manager.increase_score()

	#Set up next snail
	next = snail_order.pop_front().instance()
	animation_player.play("fade_in")
	next_spawn_pos = get_next_spawn_pos()
	landing_indicator.modulate.a = 0
	landing_indicator.position = next_spawn_pos
	emit_signal("next_snail", next.name)
	if snail_order.size() < 3:
		generate_more_snails()

func generate_more_snails():
	for _i in range(1,5):
		snail_order.append(random_snail())

func random_snail():
	var random_n = rng.randi_range(1,100)
	if random_n < 51:
		return normal_snail
	elif random_n < 71:
		return speedy_snail
	elif random_n < 91:
		if speedy_not_seen:
			return speedy_snail
		else: return big_snail
	else:
		if speedy_not_seen:
			return speedy_snail
		elif big_not_seen:
			return big_snail
		else: return rebel_snail

func populate_spawn_locations():
	#We don't allow spawns right next to the wall to prevent snails immediately crashing into it
	var pos: Vector2
	for i in range(64,1088,32):
		for j in range(64,1088,32):
			pos = Vector2(i,j)
			valid_spawn_positions.append(pos)

func get_next_spawn_pos():
	var random_n = rng.randi_range(0,valid_spawn_positions.size()-1)
	return valid_spawn_positions[random_n]

func get_snail_initial_direction():
	var random_n = rng.randi_range(0,3)
	var output: Vector2
	match(random_n):
		0:
			output = Vector2.UP
		1:
			output = Vector2.DOWN
		2:
			output = Vector2.LEFT
		3:
			output = Vector2.RIGHT
		_:
			print("You did something wrong")
			output = Vector2.UP
			
	return output

func _on_pause():
	animation_player.stop(false)

func _on_unpause():
	animation_player.play()

func check_music_and_play_tutorial(name):
	if name.find("Speedy") != -1 and speedy_not_seen:
		speedy_not_seen = false
		if game_state_manager.is_tutorial:
			emit_signal("play_tutorial", 3)
		# yield(music_controller.normal_theme_player, "finished")
		music_controller.changeSound("speedy_theme")

	elif name.find("Big") != -1 and big_not_seen:
		big_not_seen = false
		if game_state_manager.is_tutorial:
			emit_signal("play_tutorial", 4)
		# yield(music_controller.speedy_theme_player, "finished")
		music_controller.changeSound("big_theme")

	elif name.find("Rebel") != -1 and rebel_not_seen:
		rebel_not_seen = false
		if game_state_manager.is_tutorial:
			emit_signal("play_tutorial", 5)
		# yield(music_controller.big_theme_player, "finished")
		music_controller.changeSound("full_theme")

