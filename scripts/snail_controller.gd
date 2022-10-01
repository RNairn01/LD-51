extends KinematicBody2D

var tile_size = 32
onready var timer = get_node("/root/Node2D/GlobalTimer")
export var snail_speed = 1
export var snail_size = 1
export var snail_direction: Vector2 = Vector2.RIGHT

func _ready():
	timer.connect("timeout", self, "_on_tick")

func _on_tick():
	print("tick")
	position += snail_speed * snail_direction * tile_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
