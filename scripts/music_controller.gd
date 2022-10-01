extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var currently_playing = null;
onready var sounds_by_key = {
	"normal_theme": get_node("./NormalThemePlayer"),
	"speedy_theme": get_node("./SpeedyThemePlayer"),
	"big_theme": get_node("./BigThemePlayer"),
	"full_theme": get_node("./FullThemePlayer"),
}


# Called when the node enters the scene tree for the first time.
func _ready():
	changeSound("normal_theme")

func changeSound(new_sound: String):
	print("Playing " + new_sound)
	if currently_playing != null:
		sounds_by_key[currently_playing].stop()
	elif currently_playing == new_sound:
		return
	currently_playing = new_sound
	var sound = sounds_by_key[new_sound]
	sound.play()

func stopCurrentSound():
	if currently_playing != null:
		sounds_by_key[currently_playing].stop()
		currently_playing = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
