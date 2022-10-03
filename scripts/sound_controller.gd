extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sounds_by_key = {
	"explosion": get_node("./ExplosionPlayer"),
	"click": get_node("./ClickPlayer"),
	"hiss": get_node("./HissPlayer")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func play_sound(new_sound: String):
	sounds_by_key[new_sound].play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
