extends Node2D

onready var grid_manager = get_node("/root/Node2D/GridClickManager")
var arrow_left = preload("res://scenes/arrows/arrow_left.tscn")
var arrow_right = preload("res://scenes/arrows/arrow_right.tscn")
var arrow_up = preload("res://scenes/arrows/arrow_up.tscn")
var arrow_down = preload("res://scenes/arrows/arrow_down.tscn")
var update_mouse_direction = false
var current_grid_position = Vector2(0,0)
var current_mouse_direction = Vector2(0,0)
var arrow_instance = arrow_down.instance()

func _ready():
	grid_manager.connect("click_in_grid", self, "_place_arrow")
	pass

func _place_arrow(grid_position: Vector2):
	current_grid_position = grid_position
	update_mouse_direction = true
	print("Place arrow at - " + str(grid_position))

func _process(_delta):
	if update_mouse_direction:
		current_mouse_direction = get_mouse_direction(current_grid_position + Vector2(16,16), get_global_mouse_position())
		update_arrow_instance(current_mouse_direction)
		if Input.is_action_just_released("left_click"):
			update_mouse_direction = false
			add_child(arrow_instance)
			update_arrow_instance(current_mouse_direction)

		
func get_mouse_direction(grid_pos, mouse_pos):
	var direction = grid_pos.direction_to(mouse_pos).snapped(Vector2.ONE)
	return direction

func update_arrow_instance(direction):
	match (direction):
		Vector2.UP:
			arrow_instance = arrow_up.instance()
		Vector2.DOWN:
			arrow_instance = arrow_down.instance()
		Vector2.LEFT:
			arrow_instance = arrow_left.instance()
		Vector2.RIGHT:
			arrow_instance = arrow_right.instance()
		_:
			print("This should not happen - arrow instance")
		
	arrow_instance.position = current_grid_position
