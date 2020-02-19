extends Node


func _ready():
	var levels_file = File.new()
	if not levels_file.file_exists("res://levels/levels.tres"):
		push_error("level files not found")
		return 

	levels_file.open("res://levels/levels.tres", File.READ)
	var content = levels_file.get_as_text()
	print (content)
	levels_file.close()
