extends "Actor.gd"

func _ready():
	._ready()
	type = TYPE.PLAYER

func _process(delta):
	
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

func end_move():
	.end_move()
	print("_______")
