extends Node2D

var normal_snail = preload("res://scenes/snails/snail_normal.tscn")
var speedy_snail = preload("res://scenes/snails/snail_speedy.tscn")
var big_snail = preload("res://scenes/snails/snail_big.tscn")
var rebel_snail = preload("res://scenes/snails/snail_rebel.tscn")
onready var timer_label = get_node("/root/Node2D/UI/SidePanel/TimerLabel")
onready var next = tutorial_snail_order.pop_front().instance()

signal next_snail

var tutorial_snail_order = [
	normal_snail, normal_snail, normal_snail, normal_snail, normal_snail, 
	speedy_snail, normal_snail, normal_snail, speedy_snail, normal_snail,
	normal_snail, big_snail, normal_snail, speedy_snail, big_snail,
	normal_snail, normal_snail, rebel_snail, normal_snail, speedy_snail
]

func _ready():
	timer_label.connect("timeout_label", self, "_on_timeout")

func _on_timeout():
	next = tutorial_snail_order.pop_front().instance()
	emit_signal("next_snail", next.name)
