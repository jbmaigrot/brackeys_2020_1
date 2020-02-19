extends Node

const  LEVELS_DIR_PATH = "res://levels"

const LEVEL_INFO_FLAG = "]"
const LEVEL_INFO_SEPARATOR = "|"

var levels = []

func _ready():
	load_level_files(list_all_level_files(LEVELS_DIR_PATH))
	
func list_all_level_files(directory_path):
	print("Retrieving all files from directory \""+ directory_path+"\" :")
	
	var files = []
	var dir = Directory.new()
	dir.open(directory_path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			print("-"+file)
			files.append(directory_path+"/"+file)
			
	dir.list_dir_end()
	
	return files
	
func load_level_files(files):
	print("Extracting levels from files and loading them into the level library.")
	for file in files:
		load_level_file(file)
	return
	
func load_level_file(file_path):
	print("Extracting levels from file \""+file_path+"\".")
	var levels_file = File.new()
	if not levels_file.file_exists(file_path):
		push_error("level file \""+file_path+"\" not found")
		return 

	levels_file.open(file_path, File.READ)
	while not levels_file.eof_reached():
			var line = levels_file.get_line()
			if line.find(LEVEL_INFO_FLAG) != -1:
				var level_infos = line.trim_prefix(LEVEL_INFO_FLAG).split(LEVEL_INFO_SEPARATOR)
				var level_world = -1
				var level_number = -1
				var level_name = ""
				if level_infos.size() >=2:
					level_world = level_infos[0]
					level_number = level_infos[1]
				if level_infos.size() >=3:
					level_name = level_infos[2]
				print ("parsing level "+level_world+"."+level_number+" : \""+level_name+"\".") 
					
	
	#var content = levels_file.get_as_text()
	#print (content)
	levels_file.close()
