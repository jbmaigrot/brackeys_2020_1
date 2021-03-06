extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	$CenterContainer/VBoxContainer/ButtonResume.connect("pressed",Globals,"hide_pause_menu")
	$CenterContainer/VBoxContainer/ButtonMainMenu.connect("pressed",Globals,"load_main_menu")
	$CenterContainer/VBoxContainer/ButtonRestart.connect("pressed",Globals,"load_level",[Globals.current_world, Globals.current_level])
