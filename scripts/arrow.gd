extends Area2D

export var arrow_direction = Vector2.DOWN
onready var arrow_place_manager = get_node("/root/Node2D/ArrowPlaceManager")


func _ready():
	pass



func _on_click(_viewport:Node, _event:InputEvent, _shape_idx:int):
	if Input.is_action_just_pressed("right_click"):
		self.queue_free()
