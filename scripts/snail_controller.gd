extends Area2D

var tile_size = 32
var target_position = null

onready var timer = get_node("/root/Node2D/GlobalTimer")
onready var arrow_place_manager = get_node("/root/Node2D/ArrowPlaceManager")
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
	self.connect("mouse_entered", arrow_place_manager, "_mouse_enter_unplacable_area")
	self.connect("mouse_exited", arrow_place_manager, "_mouse_leave_unplacable_area")

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
	elif area.name.find("Snail") != -1 or area.name.find("Wall") != -1:
		crash_and_explode(area)

func crash_and_explode(collidee: Area2D):
	print(self.name + " - collision with - " + collidee.name)
	if(self.name < collidee.name or collidee.name.find("Wall") != -1): # Only spawn one explosion
		var explosion = load("res://scenes/explosion.tscn").instance()
		explosion.set_position(self.target_position) # Set the explosion in the square we were moving into
		get_node("/root/Node2D").add_child(explosion)
	collidee.queue_free()
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
			sprite.rotation_degrees = 0
		Vector2.LEFT:
			sprite.flip_h = false 
			sprite.rotation_degrees = 0


func move_tween(target):
	self.target_position = target
	tween.interpolate_property(self, "position",
		position, target,
		1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
