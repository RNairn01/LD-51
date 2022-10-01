extends Node2D

export var grid_lower_x_bound = 0
export var grid_lower_y_bound = 0
export var grid_upper_x_bound = 1140
export var grid_upper_y_bound = 1140

onready var grid_area = $GridArea


func _ready():
	grid_area.connect("input_event", self, "_on_click_in_grid")

func _on_click_in_grid(viewport: Node, event: InputEventMouseButton, shape_idx: int):
	if event is InputEventMouseButton and event.is_pressed():
		get_nearest_grid_center(get_global_mouse_position())

func get_nearest_grid_center(mouse_position: Vector2):
	var x_pos = round_to_nearest_multiple(mouse_position.x, 32)
	var y_pos = round_to_nearest_multiple(mouse_position.y, 32)
	print(Vector2(x_pos,y_pos))

func round_to_nearest_multiple(n, multiple):
	return multiple * floor(n / multiple)
