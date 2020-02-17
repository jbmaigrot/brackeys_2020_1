extends TileMap

enum {EMPTY, PLAYER, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size();
var half_tile_size = tile_size / 2;

var grid_size = Vector2(16,16)
var grid = [];

onready var Player = preload("res://scenes/Player.tscn")
const PLAYER_STARTPOS = Vector2(4,4)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create Grid
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(EMPTY)

	# Player
	var new_player = Player.instance()
	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	#grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
	add_child(new_player)
		
	# Generate Levels (Obstacles now)
	
	

func is_cell_free(pos, direction):
	# Return true if cell is empty
	var target_grid_pos = world_to_map(pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			return true if grid[target_grid_pos.x][target_grid_pos.y] == EMPTY else false
	return false

func update_actor_pos(actor, direction):
	# Move an actor to a new position is the grid array
	var this_grid_pos = world_to_map(actor)
	var new_grid_pos = this_grid_pos + direction

	# remove player from current grid location
	# grid[this_grid_pos.x][this_grid_pos.y] = EMPTY

	# place player on new grid location
	# grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos

