extends Node


onready var timer = get_node("/root/Node2D/GlobalTimer")
var ticks_counted = 0
var ticks_to_die = 3

func _ready():
	timer.connect("timeout", self, "_die")

func _die():
	if ticks_counted < ticks_to_die-1:
		ticks_counted +=1
		print(ticks_counted)
	else: 
		print("end")
		self.queue_free()
	