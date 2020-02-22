extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/VBoxContainer/CheckButtonMusic.connect("toggled",SoundManager,"music_toggled")
	$HBoxContainer/VBoxContainer/CheckButtonSounds.connect("toggled",SoundManager, "sounds_toggled")


