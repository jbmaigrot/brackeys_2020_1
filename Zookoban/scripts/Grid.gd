extends TileMap

enum TYPE {EMPTY, PLAYER, ANIMAL, SOCKET, OBSTACLE, WALL, COLLECTIBLE}

var tile_size = get_cell_size();
var half_tile_size = tile_size / 2;

var grid_size = Vector2(20,10)
var grid = [];

onready var Player = preload("res://scenes/actors/Player.tscn")
onready var Animal = preload("res://scenes/actors/Animal.tscn")
onready var AnimalSocket = preload("res://scenes/actors/AnimalSocket.tscn")
const PLAYER_STARTPOS = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create Grid
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(TYPE.EMPTY)
			#This set the "cell" type to use
			set_cell(x,y,0)
	# This updates the "Autotiling" based on how the grid is filled
	update_bitmask_region(Vector2(0,0),grid_size)

	Player
	var new_player = Player.instance()
	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = TYPE.PLAYER
	add_child(new_player)
		
	
	# Generate Level
	# TEMP Add Animal
	var new_animal = Animal.instance()
	new_animal.position = map_to_world(Vector2(5,5)) + half_tile_size
	grid[5][5] = TYPE.ANIMAL
	add_child(new_animal)
	
	var new_animal2 = Animal.instance()
	new_animal2.position = map_to_world(Vector2(6,5)) + half_tile_size
	grid[6][5] = TYPE.ANIMAL
	add_child(new_animal2)
	
	# TEMP Add Animal Socket
	var new_socket = AnimalSocket.instance()
	new_socket.position = map_to_world(Vector2(8,5)) + half_tile_size
	grid[8][5] = TYPE.SOCKET
	add_child(new_socket)
	

func grid_setup():
	pass

func is_cell_free(pos, direction):
	var target_grid_pos = world_to_map(pos) + direction
	print("TARGET : " + str(target_grid_pos))
	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return target ID
			return grid[target_grid_pos.x][target_grid_pos.y]

func get_actor_in_cell(pos, dir):
	for node in get_children():
		if world_to_map(node.position) == world_to_map(pos) + dir:
			print(node)
			return(node)
		else:
			print("NO TARGET")

func grid_move(actor, direction):
	# Move an actor to a new position is the grid array
	var actor_grid_pos = world_to_map(actor.position)
	var new_grid_pos = actor_grid_pos + direction

	# remove actor from current grid coord
	grid[actor_grid_pos.x][actor_grid_pos.y] = TYPE.EMPTY
	grid[new_grid_pos.x][new_grid_pos.y] = actor.type
	# place actor in new grid coord
	
	return map_to_world(new_grid_pos) + half_tile_size

func grid_refresh_actor_type(actor):
	var actor_grid_pos = world_to_map(actor.position)
	grid[actor_grid_pos.x][actor_grid_pos.y] = actor.type
	pass

func grid_move_check(actor, direction):
	var test_pos = world_to_map(actor.position) + direction
	if test_pos.x >= grid_size.x or test_pos.y >= grid_size.y or test_pos.x < 0 or test_pos.y < 0:
		return false
	else:
		return true
