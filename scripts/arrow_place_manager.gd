extends Node2D

onready var grid_manager = get_node("/root/Node2D/GridClickManager")
var arrow = preload("res://scenes/arrows/arrow_down.tscn")

func _ready():
	grid_manager.connect("click_in_grid", self, "_place_arrow")
	pass

func _place_arrow(grid_position: Vector2):
	print("Place arrow at - " + str(grid_position))
	var arrow_instance = arrow.instance()
	arrow_instance.position = grid_position
	add_child(arrow_instance)
