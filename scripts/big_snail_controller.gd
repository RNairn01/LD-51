extends "res://scripts/snail_controller.gd"

const arrow_collision_epsilon = 100
onready var last_collided_with_arrow_time = 0

func _on_collide(area: Area2D):
	if area.name.find("Arrow") != -1:
		var collision_time = Time.get_ticks_msec()
		if (collision_time - last_collided_with_arrow_time) < arrow_collision_epsilon:
			if self.target_position != null:
				self.target_position += Vector2(16, 16) # Dumb hack to make the explosion go in the middle of the snail if we hit two arrows
			crash_and_explode(area)
		else:
			self.snail_direction = area.arrow_direction
			last_collided_with_arrow_time = collision_time
		area.queue_free()
	elif area.name.find("Snail") != -1 or area.name.find("Wall") != -1:
		crash_and_explode(area)
