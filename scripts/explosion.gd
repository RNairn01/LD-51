extends Node


onready var timer = get_node("/root/Node2D/GlobalTimer")
onready var game_state_manager = get_node("/root/Node2D/GameStateManager")
var ticks_counted = 0
var ticks_to_die = 3

func _ready():
	self.connect("ready", game_state_manager, "_lose_life")
	timer.connect("timeout", self, "_die")

func _die():
	if ticks_counted < ticks_to_die-1:
		ticks_counted +=1
	else: 
		self.queue_free()
	
