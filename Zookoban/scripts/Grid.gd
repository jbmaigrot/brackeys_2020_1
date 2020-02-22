extends TileMap

enum TYPE {EMPTY, PLAYER, ANIMAL, SOCKET, OBSTACLE, WALL, COLLECTIBLE}
enum ANIMALS {CUBE, CIRCLE, LOSANGE, CROSS}

var tile_size = get_cell_size();
var half_tile_size = tile_size / 2;

var grid_size
var grid = [];
var currentlevel

var currentmove

var level_goal
var goal_progression

var camera

onready var SPlayer = preload("res://scenes/actors/Player.tscn")
onready var SAnimal = preload("res://scenes/actors/Animal.tscn")
onready var SAnimalSocket = preload("res://scenes/actors/AnimalSocket.tscn")
onready var SButton = preload("res://scenes/actors/Button.tscn")
onready var SDoor = preload("res://scenes/actors/Door.tscn")

const PLAYER_STARTPOS = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Test Level Generation
	camera = get_parent().find_node("Camera2D")
	if (Globals.current_world == -1):
		Globals.current_world = 1
		Globals.current_level = 1
	generate_level(LevelLibrary.levels[Globals.current_world][Globals.current_level]["levels"])
	

func generate_level(level):
	currentmove = 0
	for node in get_children():
		node.visible = false
		node.queue_free()
	currentlevel = level
	grid = [];
	goal_progression = 0
	level_goal = 0
	
	for x in range(level.size()):
		grid.append([])
		for y in range(level[x].size()):
			grid[x].append([])
			var grass_rand = int(rand_range(4,14))
			var obs_rand = int(rand_range(16,18))
			var object
#			=======
#			LEGEND
#			=======
#			. = Background
#			# = Wall
#			@ = Player
#			c = Cube
#			ĉ = CubeHole
#			o = Sphere
#			ô = SphereHole
#			s = Star
#			ŝ = StarHole
#			x = Cross
#			+ = CrossHole
#			b = Button
#			d = Door
#			p = OpenDoor
			match level[x][y]:
				"ĉ":
					add_actor(SAnimalSocket,Vector2(x,y), ANIMALS.CUBE)
					set_cell(x,y,grass_rand)
					level_goal += 1
				
				"c":
					add_actor(SAnimal,Vector2(x,y), ANIMALS.CUBE)
					set_cell(x,y,grass_rand)
					
				
				"ô":
					add_actor(SAnimalSocket,Vector2(x,y), ANIMALS.CIRCLE)
					set_cell(x,y,grass_rand)
					level_goal += 1
				
				"o":
					add_actor(SAnimal,Vector2(x,y), ANIMALS.CIRCLE)
					set_cell(x,y,grass_rand)
				
				"ŝ":
					add_actor(SAnimalSocket,Vector2(x,y), ANIMALS.LOSANGE)
					set_cell(x,y,grass_rand)
					level_goal += 1
				
				"s":
					add_actor(SAnimal,Vector2(x,y), ANIMALS.LOSANGE)
					set_cell(x,y,grass_rand)
					
				
				"+":
					add_actor(SAnimalSocket,Vector2(x,y), ANIMALS.CROSS)
					set_cell(x,y,grass_rand)
					level_goal += 1
				
				"x":
					add_actor(SAnimal,Vector2(x,y), ANIMALS.CROSS)
					set_cell(x,y,grass_rand)
					
				"#":
					grid[x][y] = TYPE.WALL
					set_cell(x,y,1)
				
				"*":
					grid[x][y] = TYPE.OBSTACLE
					set_cell(x,y,obs_rand)
				
				"T":
					grid[x][y] = TYPE.OBSTACLE
					set_cell(x,y,2)
				
				"@":
					add_actor(SPlayer,Vector2(x,y))
					set_cell(x,y,grass_rand)
				
				"b":
					add_actor(SButton,Vector2(x,y))
					set_cell(x,y,grass_rand)
				
				"d":
					add_actor(SDoor,Vector2(x,y))
					set_cell(x,y,grass_rand)
				
				_:
					grid[x][y]  = TYPE.EMPTY
					set_cell(x,y,grass_rand)
	
	grid_size = Vector2(grid.size(),grid[0].size())
	camera.position = grid_size * 64
	# This updates the "Autotiling" based on how the grid is filled
	update_bitmask_region()
	
	

func reset_level():
	for node in get_children():
		node.visible = false
		node.queue_free()
	generate_level(currentlevel)

func add_actor(actor,pos,animaltype = -1):
	var new_actor = actor.instance()
	new_actor.position = map_to_world(pos) + half_tile_size
	if (animaltype != -1):
		new_actor.animal_type = animaltype
	add_child(new_actor)
	grid[pos.x][pos.y] = new_actor.type



func is_cell_free(pos, direction):
	var target_grid_pos = world_to_map(pos) + direction
	print("TARGET : " + str(target_grid_pos))
	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return target ID
			print (grid[target_grid_pos.x][target_grid_pos.y])
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

func rewind():
	var rewinded = false
	if currentmove != 0:
		for node in get_children():
			if node is Actor:
				for i in node.memory.size():
					if node.memory[i].find(str(currentmove-1)) != -1:
						print(str(node.memory) + " -- " + str(node.name))
						node.type = node.memory[i][2]
						node.move(-node.memory[i][1],true)
						node.memory.remove(i)
						rewinded = true
	if rewinded:
		currentmove -= 1

func _process(delta):
	if (goal_progression == level_goal):
		print("WIN")
		Globals.display_end_level()
