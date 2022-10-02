extends Control

onready var game_state_manager = get_node("/root/Node2D/GameStateManager")
onready var life_lost_sprite = preload("res://assets/sprites/life_lost.png")
onready var life_1 = $Life1
onready var life_2 = $Life2
onready var life_3 = $Life3


func _ready():
	game_state_manager.connect("life_lost", self, "_lose_life")

func _lose_life(remaining):
	if remaining == 2:
		life_3.texture = life_lost_sprite
	elif remaining == 1:
		life_2.texture = life_lost_sprite
	elif remaining == 0:
		life_1.texture = life_lost_sprite
