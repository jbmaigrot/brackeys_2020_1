extends KinematicBody2D

enum TYPE {EMPTY, PLAYER, ANIMAL, INSOCKET, SOCKET, OBSTACLE, COLLECTIBLE}
var target_direction = Vector2()
var world_target_pos = Vector2()
var is_moving = false

var type

var velocity = Vector2();

var speed = 0;

const MAXSPEED = 1000;

var grid

func _ready():
	grid = get_parent()
	set_process(true)


func move(dir):
	
	check_push(dir)
	
	var pos_translation =  grid.grid_move(self, dir) - position
							
	#grid.grid_move(self, dir)
# warning-ignore:return_value_discarded
	move_and_collide(pos_translation)
	end_move()
	return true

func check_push(dir):
	print(grid.is_cell_free(position, dir))
	
	match grid.is_cell_free(position, dir):
			TYPE.EMPTY, TYPE.SOCKET, TYPE.INSOCKET:
				pass
			TYPE.ANIMAL:
				for node in grid.get_children():
					if grid.world_to_map(node.position) == grid.world_to_map(position) + dir :
						node.move(dir)

func end_move():
	grid.grid_refresh_actor_type(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
