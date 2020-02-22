extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/ButtonResume.connect("pressed",Globals,"hide_pause_menu")
	$CenterContainer/VBoxContainer/ButtonMainMenu.connect("pressed",Globals,"load_main_menu")
