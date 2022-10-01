extends "res://scripts/snail_controller.gd"

onready var timer_half = get_node("/root/Node2D/GlobalTimer/HalfTickTimer")

func _ready():
	timer_half.connect("timeout", self, "_on_tick")

func _on_tick():
	._on_tick()

