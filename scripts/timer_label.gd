extends Label

signal timeout_label

onready var timer = get_node("/root/Node2D/GlobalTimer")
var current_time = 10

func _ready():
	timer.connect("timeout", self, "_on_tick")
	self.text = str(current_time)
	self.connect("timeout_label", self, "_on_timeout")

func _on_tick():
	current_time -= 1
	if current_time > 0:
		self.text = str(current_time)
	else:
		current_time = 10
		self.text = str(current_time)
		self.emit_signal("timeout_label")

func _on_timeout():
	print("timer reset")
