extends Node2D

onready var grid_area = $GridArea

signal click_in_grid(grid_pos)

func _ready():
	grid_area.connect("input_event", self, "_on_click_in_grid")

func _on_click_in_grid(viewport: Node, event: InputEventMouseButton, shape_idx: int):
	if Input.is_action_just_pressed("left_click"):
		var grid_pos = get_nearest_grid_center(get_global_mouse_position())
		emit_signal("click_in_grid", grid_pos)

func get_nearest_grid_center(mouse_position: Vector2):
	var x_pos = round_to_nearest_multiple(mouse_position.x, 32)
	var y_pos = round_to_nearest_multiple(mouse_position.y, 32)
	var grid_pos = Vector2(x_pos,y_pos)
	return grid_pos

func round_to_nearest_multiple(n, multiple):
	return multiple * floor(n / multiple)
