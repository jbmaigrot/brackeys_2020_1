extends CenterContainer


export (String, FILE) var first_scene_temp


func _ready():
	$VBoxContainer/Button_Back.connect("pressed", self, "back_button_pressed")

	
func back_button_pressed():
	get_node("/root/Globals").load_main_menu()
	

