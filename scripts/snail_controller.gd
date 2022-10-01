extends Area2D

var tile_size = 32
onready var timer = get_node("/root/Node2D/GlobalTimer")
onready var tween = $Tween
onready var sprite = $SnailSprite
export var tween_speed = 3
export var snail_speed = 1
export var snail_size = 1
export var snail_direction: Vector2 = Vector2.RIGHT

func _ready():
	timer.connect("timeout", self, "_on_tick")
	# This could be done in the editor but I think it's more descriptive in code.
	self.connect("area_entered", self, "_on_collide")

func _on_tick():
	var move_target = position + snail_speed * snail_direction * tile_size
	set_sprite_facing(snail_direction)
	move_tween(move_target)

func _on_collide(area: Area2D):
	# if area.name != "GridArea":
	# 	print("collide" + "-" + area.name)
	if area.name.find("Arrow") != -1:
		self.snail_direction = area.arrow_direction
		area.queue_free()
	elif area.name.find("Snail") != -1:
		print(self.name + " - collision with - " + area.name)
		area.queue_free()
		self.queue_free()

func set_sprite_facing(direction: Vector2):
	match (direction):
		Vector2.UP:
			if sprite.flip_h:
				sprite.rotation_degrees = -90
			else: sprite.rotation_degrees = 90
		Vector2.DOWN:
			if sprite.flip_h:
				sprite.rotation_degrees = 90
			else: sprite.rotation_degrees = -90
		Vector2.RIGHT:
			sprite.flip_h = true 
		Vector2.LEFT:
			sprite.flip_h = false 


func move_tween(target):
	tween.interpolate_property(self, "position",
		position, target,
		1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
