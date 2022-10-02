extends Timer

onready var half_tick_timer = $HalfTickTimer
onready var game_state_manager = get_node("/root/Node2D/GameStateManager")

func _ready():
	game_state_manager.connect("game_pause", self, "_on_pause")
	game_state_manager.connect("game_unpause", self, "_on_unpause")

func _on_pause():
	self.stop()
	half_tick_timer.stop()

func _on_unpause():
	self.start()
	half_tick_timer.start()