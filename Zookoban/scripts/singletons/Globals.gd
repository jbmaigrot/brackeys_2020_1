extends Node

const MAIN_MENU_PATH = "res://scenes/MainMenu.tscn"
const LEVEL_SELECT_MENU_PATH = "res://scenes/LevelSelectMenu.tscn"

func _ready():
	pass 

func load_new_scene(new_scene_path):
	get_tree().change_scene(new_scene_path)
	
func load_main_menu():
	load_new_scene(MAIN_MENU_PATH)
	
func load_level_select_menu():
	load_new_scene(LEVEL_SELECT_MENU_PATH)
