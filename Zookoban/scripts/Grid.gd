extends TileMap

enum {EMPTY, PLAYER, ANIMAL, SOCKET, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size();
var half_tile_size = tile_size / 2;

var grid_size = Vector2(16,16)
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
			grid[x].append(EMPTY)

	# Player
	#var new_player = Player.instance()
	#new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	#grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
	#add_child(new_player)
		
	
	# Generate Level
	# TEMP Add Animal
	var new_animal = Animal.instance()
	new_animal.position = map_to_world(Vector2(5,5)) + half_tile_size
	grid[5][5] = ANIMAL
	add_child(new_animal)
	
	var new_animal2 = Animal.instance()
	new_animal2.position = map_to_world(Vector2(6,5)) + half_tile_size
	grid[6][5] = ANIMAL
	add_child(new_animal2)
	
	# TEMP Add Animal Socket
	var new_socket = AnimalSocket.instance()
	new_socket.position = map_to_world(Vector2(8,5)) + half_tile_size
	grid[8][5] = SOCKET
	add_child(new_socket)
	

func is_cell_free(pos, direction):
	# Return true if cell is empty
	var target_grid_pos = world_to_map(pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
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
	grid[actor_grid_pos.x][actor_grid_pos.y] = EMPTY

	# place actor in new grid coord
	grid[new_grid_pos.x][new_grid_pos.y] = actor.type

	var new_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_pos

