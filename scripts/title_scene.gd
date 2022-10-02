extends Control

onready var scene_manager = get_node("/root/SceneManager")
onready var tutorial_toggle = $Layer6/CheckBoxBackground/Button
onready var play_button = $Layer6/PlayButton


func _ready():
	tutorial_toggle.connect("button_down", scene_manager, "_toggle_tutorial")
	play_button.connect("button_down", scene_manager, "_on_click_play")
