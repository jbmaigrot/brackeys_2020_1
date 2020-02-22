extends "Actor.gd"

func _ready():
	._ready()
	type = TYPE.PLAYER

func _process(delta):
	
	action_input()
	
	var direction = move_input()
	
	if direction != Vector2(0,0):
		if(move(direction)):
			pass
			# Increase move count
				

func move_input():
	var dir = Vector2(0,0)
	if Input.is_action_just_pressed("move_up"):
		dir.y = -1
	elif Input.is_action_just_pressed("move_down"):
		dir.y = 1
	elif Input.is_action_just_pressed("move_left"):
		dir.x = -1
	elif Input.is_action_just_pressed("move_right"):
		dir.x = 1
	else:
		dir = Vector2(0,0)
		
	return dir

func action_input():
	if Input.is_action_just_pressed("ui_cancel"):
		Globals.display_pause_menu();
	
	if Input.is_action_just_pressed("action_reset"):
		grid.reset_level()

func end_move():
	.end_move()
	print("_______")
