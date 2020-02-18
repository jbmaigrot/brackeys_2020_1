extends "Actor.gd"

func _ready():
	._ready()
	type = PLAYER

func _process(delta):
	
	direction = move_input()
	
	if direction == Vector2(0,0):
		is_moving = false
	else:
		match grid.is_cell_free(position, direction):
			EMPTY:
				move(direction)
			ANIMAL:
				for node in grid.get_children():
					if node.type == ANIMAL:
						print ("PLAYER : " + str(grid.world_to_map(self.position)))
						print ("ACTOR : " + str(grid.world_to_map(node.position)))
						
						if grid.world_to_map(node.position) == grid.world_to_map(self.position) + direction :
							grid.grid_move(node, direction)
							node.move(direction)
							print(str(node.type) +" MOVE")
						
				print("SELF MOVE")
				move(direction)
				

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
