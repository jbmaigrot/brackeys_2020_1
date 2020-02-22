extends Node

const MAIN_MENU_PATH = "res://scenes/MainMenu.tscn"
const LEVEL_SELECT_MENU_PATH = "res://scenes/LevelSelectMenu.tscn"
const GAME_SCENE = "res://scenes/MainScene.tscn"

var current_world = -1
var current_level = -1

func _ready():
	pass 

func load_new_scene(new_scene_path):
	get_tree().change_scene(new_scene_path)
	
func load_main_menu():
	load_new_scene(MAIN_MENU_PATH)
	
func load_level_select_menu():
	load_new_scene(LEVEL_SELECT_MENU_PATH)

func load_level(world_idx,level_idx):
	current_world = world_idx
	current_level = level_idx
	
	load_new_scene(GAME_SCENE)
