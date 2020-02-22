extends CenterContainer


export (String, FILE) var first_scene_temp


func _ready():
	$VBoxContainer/Button_Back.connect("pressed", self, "back_button_pressed")
	
	for world_idx in LevelLibrary.levels:
		for level_idx in LevelLibrary.levels[world_idx]:
			var level_info = LevelLibrary.levels[world_idx][level_idx]
			var button = Button.new()
			button.text = str(world_idx)+"."+str(level_idx)
			button.connect("pressed",self, "level_button_pressed", [world_idx,level_idx])
			$VBoxContainer/GridContainer.add_child(button)

	
func back_button_pressed():
	Globals.load_main_menu()
	

func level_button_pressed(world_idx, level_idx):
	print(str(world_idx)+"."+str(level_idx))
	Globals.load_level(world_idx,level_idx)
