extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tracks_by_name

# Called when the node enters the scene tree for the first time.
func _ready():
	tracks_by_name = _preload_all_dialogue()

func _preload_all_dialogue():
	var tracks_to_load = [
		"Tutorial00", "Tutorial01","Tutorial02", "Tutorial03", "Tutorial04", "Tutorial05",
		"Tutorial10", "Tutorial20", "Tutorial30",
		"Fail0", "Fail1",
		"Win0", "Win1"
	]
	
	var tracks_by_name = {}
	for track_name in tracks_to_load:
		tracks_by_name[track_name] = load("res://assets/sfx/dialogue/" + track_name + ".ogg")
		
	return tracks_by_name

func playTrack(track_name: String):
	if playing:
		stop()
	stream = tracks_by_name[track_name]
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
