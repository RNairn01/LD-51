extends Node

var tutorial_selected = true
var game_scene = "res://scenes/screens/play_screen.tscn"
var title_scene = "res://scenes/screens/title_scene.tscn"
var high_score_scene = ""


func _ready():
	pass

func _on_click_play():
	get_tree().change_scene(game_scene)

func _toggle_tutorial():
	tutorial_selected = not tutorial_selected
	print(tutorial_selected)
