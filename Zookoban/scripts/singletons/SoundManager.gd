extends Node

var music_volume = 1
var sounds_volume = 1

var music
var sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	# Create Music Player
	music = AudioStreamPlayer.new()
	self.add_child(music)
	music.bus = "Music"
	music.stream = load("res://audio/music/music.ogg")
	music.play()
	
	# Create SFX Player
	sfx = AudioStreamPlayer.new()
	self.add_child(sfx)
	sfx.bus = "SFX"
	pass # Replace with function body.


func music_toggled(activated):
	if activated:
		music.play()
	else:
		music.stop()
	
func sounds_toggled(activated):
	if activated:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
		
func play_sfx(path):
		var sel = 0
		if path.size() != 1:
			sel = randi()%path.size()-1
		sfx.stream = load(path[sel])
		sfx.play()
