extends Control

onready var game_state_manager = get_node("/root/Node2D/GameStateManager")
onready var score_display = $ScoreDisplayLabel

func _ready():
	score_display.text = str(game_state_manager.current_score)
	game_state_manager.connect("score_increase", self, "_increase_score")

func _increase_score(new_score):
	score_display.text = str(new_score)
