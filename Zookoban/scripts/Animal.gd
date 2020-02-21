extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, CROSS}

var animal_type

var sprite

# Animals
onready var spr_cube = preload("res://sprites/animals/A_square.png")
onready var spr_circle = preload("res://sprites/animals/A_circle.png")
onready var spr_losange = preload("res://sprites/animals/A_losange.png")
onready var spr_cross = preload("res://sprites/animals/A_cross.png")

onready var spr_cube_s = preload("res://sprites/animals/A_square_sleep.png")
onready var spr_circle_s = preload("res://sprites/animals/A_circle_sleep.png")
onready var spr_losange_s = preload("res://sprites/animals/A_losange_sleep.png")
onready var spr_cross_s = preload("res://sprites/animals/A_cross_sleep.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	
	sprite = get_node("Sprite")
	
	type = TYPE.ANIMAL
	if (animal_type == null):
		animal_type  = ANIMALS.LOSANGE
	
	# Define sprite depending on Animal type
	match animal_type:
		ANIMALS.CUBE:
			sprite.texture = spr_cube
		ANIMALS.CIRCLE:
			sprite.texture = spr_circle
		ANIMALS.LOSANGE:
			sprite.texture = spr_losange
		ANIMALS.CROSS:
			sprite.texture = spr_cross

func _process(delta):
	if type == TYPE.EMPTY:
		match animal_type:
			ANIMALS.CUBE:
				sprite.texture = spr_cube_s
			ANIMALS.CIRCLE:
				sprite.texture = spr_circle_s
			ANIMALS.LOSANGE:
				sprite.texture = spr_losange_s
			ANIMALS.CROSS:
				sprite.texture = spr_cross_s
		z_index = 2

func end_move():
	.end_move()
	for node in grid.get_children():
		if node.type == TYPE.SOCKET and node.filled == false:
			if grid.world_to_map(node.position) == grid.world_to_map(self.position):
				match animal_type:
					ANIMALS.CUBE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.CIRCLE:
								pass
							ANIMALS.LOSANGE:
								pass
							ANIMALS.CROSS:
								pass
					ANIMALS.CIRCLE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.CIRCLE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.LOSANGE:
								pass
							ANIMALS.CROSS:
								pass
					ANIMALS.LOSANGE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.CIRCLE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.LOSANGE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.CROSS:
								pass
					ANIMALS.CROSS:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.EMPTY
								node.filled = true
							ANIMALS.CIRCLE:
								pass
							ANIMALS.LOSANGE:
								pass
							ANIMALS.CROSS:
								type = TYPE.EMPTY
								node.filled = true
				if node.filled:
					grid.grid_refresh_actor_type(self)
