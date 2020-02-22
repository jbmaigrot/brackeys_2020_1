extends Control


func _ready():
	$CenterContainer/ButtonMainMenu.connect("pressed",Globals,"load_main_menu")
