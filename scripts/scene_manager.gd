extends Node

var tutorial_selected = true
var final_score = 0
var game_scene = "res://scenes/screens/play_screen.tscn"
var title_scene = "res://scenes/screens/title_scene.tscn"
var high_score_scene = "res://scenes/screens/high_score_screen.tscn"


func _ready():
	pass

func _on_click_play():
	get_tree().change_scene(game_scene)

func _toggle_tutorial():
	tutorial_selected = not tutorial_selected

func _on_click_main_menu():
	get_tree().change_scene(title_scene)

func _load_high_score_scene():
	get_tree().change_scene(high_score_scene)
