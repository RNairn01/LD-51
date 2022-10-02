extends Control

onready var scene_manager = get_node("/root/SceneManager")
onready var main_menu_button = $MainMenuButton
onready var score = $SpeechBubble/ScoreCountLabel


func _ready():
	main_menu_button.connect("button_down", scene_manager, "_on_click_main_menu")
	score.text = str(scene_manager.final_score)
