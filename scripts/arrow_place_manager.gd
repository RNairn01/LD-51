extends Node2D

onready var grid_manager = get_node("/root/Node2D/GridClickManager")
onready var placement_guide = $PlacementGuide
onready var arrow_sound = $ArrowSound
var arrow_left = preload("res://scenes/arrows/arrow_left.tscn")
var arrow_right = preload("res://scenes/arrows/arrow_right.tscn")
var arrow_up = preload("res://scenes/arrows/arrow_up.tscn")
var arrow_down = preload("res://scenes/arrows/arrow_down.tscn")
var update_mouse_direction = false
var current_grid_position = Vector2(0,0)
var current_mouse_direction = Vector2(0,0)
var arrow_instance = arrow_down.instance()
var can_place = true

func _ready():
	grid_manager.connect("click_in_grid", self, "_place_arrow")
	pass

func _place_arrow(grid_position: Vector2):
	if can_place:
		current_grid_position = grid_position
		update_mouse_direction = true
		print("Place arrow at - " + str(grid_position))

func _process(_delta):
	if update_mouse_direction:
		current_mouse_direction = get_mouse_direction(current_grid_position + Vector2(16,16), get_global_mouse_position())
		placement_guide.visible = true
		placement_guide.position = current_grid_position + Vector2(16,16)
		update_placement_guide(current_mouse_direction)
		update_arrow_instance(current_mouse_direction)
		if Input.is_action_just_released("left_click") and arrow_instance.get_parent() == null:
			print("release")
			arrow_instance.position = current_grid_position
			update_mouse_direction = false
			placement_guide.visible = false
			add_child(arrow_instance)
			arrow_sound.play()
			update_arrow_instance(current_mouse_direction)

		
func get_mouse_direction(grid_pos, mouse_pos):
	var direction = grid_pos.direction_to(mouse_pos).snapped(Vector2.ONE)
	return direction

func update_placement_guide(direction):
	match (direction):
		Vector2.UP:
			placement_guide.flip_v = true
			placement_guide.rotation_degrees = 0
		Vector2.DOWN:
			placement_guide.flip_v = false
			placement_guide.rotation_degrees = 0
		Vector2.LEFT:
			placement_guide.flip_v = false
			placement_guide.rotation_degrees = 90
		Vector2.RIGHT:
			placement_guide.flip_v = false
			placement_guide.rotation_degrees = -90

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
		
	# if is_instance_valid(arrow_instance) and not arrow_instance.is_queued_for_deletion():
	# 	arrow_instance.position = current_grid_position

func _mouse_enter_unplacable_area():
	can_place = false

func _mouse_leave_unplacable_area():
	can_place = true
