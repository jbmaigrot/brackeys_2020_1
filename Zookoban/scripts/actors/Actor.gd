extends KinematicBody2D

class_name Actor

enum TYPE {EMPTY, PLAYER, ANIMAL, SOCKET, OBSTACLE, WALL, SOCKETFILLED}

var target_direction = Vector2()
var world_target_pos = Vector2()
var is_moving = false

var type = TYPE.EMPTY

var velocity = Vector2();

var grid

var memory = []

func _ready():
	memory = []
	grid = get_parent()
	set_process(true)


func move(dir, re = false):
	if(grid.grid_move_check(self,dir) or re):
		if (check_push(dir) or re):
			if !re: memory.append([str(grid.currentmove), dir])
			var pos_translation =  grid.grid_move(self, dir) - position
									
			#grid.grid_move(self, dir)
			# warning-ignore:return_value_discarded
			move_and_collide(pos_translation)
			end_move(re)
			return true
	else:
		return false

func check_push(dir):	
	match grid.is_cell_free(position, dir):
			TYPE.EMPTY, TYPE.SOCKET, TYPE.SOCKETFILLED:
				return true
			TYPE.ANIMAL:
				for node in grid.get_children():
					if node.type == TYPE.ANIMAL:
						if grid.world_to_map(node.position) == grid.world_to_map(position) + dir :
							return node.move(dir,false)
			TYPE.OBSTACLE, TYPE.WALL:
				return false

func end_move(re):
	grid.grid_refresh_actor_type(self)
	if !re:
		memory[memory.size()-1].append(type)
		print("CUR MEM = " +str(memory[memory.size()-2]))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
