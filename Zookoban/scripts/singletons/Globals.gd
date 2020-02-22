extends Node

const MAIN_MENU_PATH = "res://scenes/MainMenu.tscn"
const LEVEL_SELECT_MENU_PATH = "res://scenes/LevelSelectMenu.tscn"
const END_LEVEL_MENU = "res://scenes/LevelEndMenu.tscn"
const FINISH_MENU = "res://scenes/FinishMenu.tscn"
const GAME_SCENE = "res://scenes/MainScene.tscn"
const MENU_PAUSE_SCENE = preload("res://scenes/PauseMenu.tscn")

var current_world = -1
var current_level = -1

var pause_menu_instance = null
var gui_canvas_layer = null

var soundmanager

func _ready():
	soundmanager = SoundManager.new()
	self.add_child(soundmanager)
	 
	gui_canvas_layer = CanvasLayer.new()
	get_tree().root.call_deferred("add_child", gui_canvas_layer)

func load_new_scene(new_scene_path):
	get_tree().change_scene(new_scene_path)
	
func load_main_menu():
	if pause_menu_instance != null:
		hide_pause_menu()
	load_new_scene(MAIN_MENU_PATH)
	
func load_level_select_menu():
	load_new_scene(LEVEL_SELECT_MENU_PATH)

func load_level(world_idx,level_idx):
	current_world = world_idx
	current_level = level_idx
	
	load_new_scene(GAME_SCENE)
	
func display_pause_menu():
	get_tree().paused = true
	print("Displaying pause menu")
	if pause_menu_instance == null :
		pause_menu_instance = MENU_PAUSE_SCENE.instance()
		gui_canvas_layer.add_child(pause_menu_instance)
	
func hide_pause_menu():
	get_tree().paused = false
	print("Hiding pause menu")
	if pause_menu_instance != null :
		pause_menu_instance.queue_free()
		pause_menu_instance = null
	
func display_end_level():
	load_new_scene(END_LEVEL_MENU)
	
func load_next_level():
	print("loading next level")
	if LevelLibrary.levels[current_world].has(current_level+1):
		load_level(current_world,current_level+1)
	elif LevelLibrary.levels.has(current_world+1) && LevelLibrary.levels[current_world+1].has(1):
		load_level(current_world+1,1)
	else :
		load_new_scene(FINISH_MENU)
