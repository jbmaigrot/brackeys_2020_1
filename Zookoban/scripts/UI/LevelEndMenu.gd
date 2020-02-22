extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	$CenterContainer/VBoxContainer/ButtonMainMenu.connect("pressed",Globals,"load_main_menu")
	$CenterContainer/VBoxContainer/ButtonRestartLevel.connect("pressed",Globals,"load_level",[Globals.current_world, Globals.current_level])
	$CenterContainer/VBoxContainer/ButtonNextLevel.connect("pressed", Globals, "load_next_level")
