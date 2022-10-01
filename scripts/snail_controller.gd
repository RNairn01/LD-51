extends Area2D

var tile_size = 32
onready var timer = get_node("/root/Node2D/GlobalTimer")
onready var tween = $Tween
export var tween_speed = 3
export var snail_speed = 1
export var snail_size = 1
export var snail_direction: Vector2 = Vector2.RIGHT

func _ready():
	timer.connect("timeout", self, "_on_tick")
    # This could be done in the editor but I think it's more descriptive in code.
	self.connect("area_entered", self, "_on_collide")

func _on_tick():
	print("tick")
	var move_target = position + snail_speed * snail_direction * tile_size
	move_tween(move_target)

func _on_collide(area: Area2D):
	print("collide" + "-" + area.name)

func move_tween(target):
	tween.interpolate_property(self, "position",
		position, target,
		1.0/snail_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
