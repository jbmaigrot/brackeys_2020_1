extends Node

var music_volume = 1
var sounds_volume = 1

var music
var sfx

# Called when the node enters the scene tree for the first time.
func _ready():
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
	sfx.stream = load("res://audio/music/music.ogg")
	pass # Replace with function body.


func music_toggled(activated):
	if activated:
		print("toggling music on")
	else:
		print("toggling music off")
	
func sounds_toggled(activated):
	if activated:
		print("toggling sounds on")
	else:
		print("toggling sounds off")
