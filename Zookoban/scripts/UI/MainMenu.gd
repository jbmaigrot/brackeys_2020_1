extends CenterContainer

export (String, FILE) var first_scene_temp


func _ready():
	$VBoxContainer/Button_Start.connect("pressed", self, "start_button_pressed")
	$VBoxContainer/Button_Level_select.connect("pressed", self, "level_select_button_pressed")
	$VBoxContainer/Button_Exit.connect("pressed", self, "exit_button_pressed")
	
func level_select_button_pressed():
	Globals.load_level_select_menu()
	
func exit_button_pressed():
	get_tree().quit()
	
func start_button_pressed():
	Globals.load_level(1,1)
