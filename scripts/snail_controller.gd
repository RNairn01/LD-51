extends Area2D

var tile_size = 32
onready var timer = get_node("/root/Node2D/GlobalTimer")
export var snail_speed = 1
export var snail_size = 1
export var snail_direction: Vector2 = Vector2.RIGHT

func _ready():
	timer.connect("timeout", self, "_on_tick")
	self.connect("area_entered", self, "_on_collide")

func _on_tick():
	print("tick")
	var move_target = snail_speed * snail_direction * tile_size
	position += move_target

func _on_collide(area: Area2D):
	print("collide" + "-" + area.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
