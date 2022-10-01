extends Node2D

var normal_snail = preload("res://scenes/snails/snail_normal.tscn")
var speedy_snail = preload("res://scenes/snails/snail_speedy.tscn")
var big_snail = preload("res://scenes/snails/snail_big.tscn")
var rebel_snail = preload("res://scenes/snails/snail_rebel.tscn")
onready var timer_label = get_node("/root/Node2D/UI/SidePanel/TimerLabel")
onready var next = snail_order.pop_front().instance()

var rng = RandomNumberGenerator.new()

signal next_snail

var snail_order = [normal_snail]
var tutorial_snail_order = [
	normal_snail, normal_snail, normal_snail, normal_snail, normal_snail, 
	speedy_snail, normal_snail, normal_snail, speedy_snail, normal_snail,
	normal_snail, big_snail, normal_snail, speedy_snail, big_snail,
	normal_snail, normal_snail, rebel_snail, normal_snail, speedy_snail
]

func _ready():
	rng.randomize()
	timer_label.connect("timeout_label", self, "_on_timeout")

	#Will update this when we add no tutorial option
	# snail_order = tutorial_snail_order.duplicate(true)
	if snail_order.size() < 5:
		generate_more_snails()

func _on_timeout():
	next = snail_order.pop_front().instance()
	emit_signal("next_snail", next.name)
	if snail_order.size() < 5:
		generate_more_snails()

func generate_more_snails():
	for _i in range(1,20):
		snail_order.append(random_snail())

func random_snail():
	var random_n = rng.randi_range(1,100)
	if random_n < 51:
		return normal_snail
	elif random_n < 71:
		return speedy_snail
	elif random_n < 91:
		return big_snail
	else:
		return rebel_snail
