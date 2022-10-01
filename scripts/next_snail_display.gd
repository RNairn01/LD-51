extends Sprite

var normal_snail_sprite = preload("res://assets/sprites/snails/normal_snail.png")
var speedy_snail_sprite = preload("res://assets/sprites/snails/speedy_snail.png")
var big_snail_sprite = preload("res://assets/sprites/snails/big_snail.png")
var rebel_snail_sprite = preload("res://assets/sprites/snails/rebel_snail.png")
onready var snail_order_manager = get_node("/root/Node2D/SnailOrderManager")
onready var snail_sprite = $NextSnailSprite
onready var animation_player = $AnimationPlayer
onready var original_size = snail_sprite.scale

func _ready():
	snail_order_manager.connect("next_snail", self, "_next_snail")

func _next_snail(next_name):
	animation_player.play("fade_out_and_in")
	if next_name.find("Normal") != -1:
		snail_sprite.texture = normal_snail_sprite
		snail_sprite.scale = original_size
	elif next_name.find("Speedy") != -1:
		snail_sprite.texture = speedy_snail_sprite
		snail_sprite.scale = original_size
	elif next_name.find("Big") != -1:
		snail_sprite.texture = big_snail_sprite
		snail_sprite.scale /= 2
	elif next_name.find("Rebel") != -1:
		snail_sprite.texture = rebel_snail_sprite
		snail_sprite.scale = original_size
