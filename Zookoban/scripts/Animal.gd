extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, STAR, CROSS}

var animal_type

var sprite

# Animals
onready var spr_cube = preload("res://sprites/animals/A_square.png")
onready var spr_circle = preload("res://sprites/animals/A_circle.png")
onready var spr_losange = preload("res://sprites/animals/A_losange.png")
onready var spr_star = preload("res://sprites/animals/A_star.png")
onready var spr_cross = preload("res://sprites/animals/A_cross.png")

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
		ANIMALS.STAR:
			sprite.texture = spr_star
		ANIMALS.CROSS:
			sprite.texture = spr_cross

func _process(delta):
	if type == TYPE.INSOCKET:
		sprite.flip_v = true

func end_move():
	.end_move()
	for node in grid.get_children():
		if node.type == TYPE.SOCKET:
			if grid.world_to_map(node.position) == grid.world_to_map(self.position):
				match animal_type:
					ANIMALS.CUBE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.INSOCKET
							ANIMALS.CIRCLE:
								pass
							ANIMALS.LOSANGE:
								pass
							ANIMALS.STAR:
								pass
							ANIMALS.CROSS:
								pass
					ANIMALS.CIRCLE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.INSOCKET
							ANIMALS.CIRCLE:
								type = TYPE.INSOCKET
							ANIMALS.LOSANGE:
								pass
							ANIMALS.STAR:
								pass
							ANIMALS.CROSS:
								pass
					ANIMALS.LOSANGE:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.INSOCKET
							ANIMALS.CIRCLE:
								type = TYPE.INSOCKET
							ANIMALS.LOSANGE:
								type = TYPE.INSOCKET
							ANIMALS.STAR:
								pass
							ANIMALS.CROSS:
								pass
					ANIMALS.STAR:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.INSOCKET
							ANIMALS.CIRCLE:
								pass
							ANIMALS.LOSANGE:
								pass
							ANIMALS.STAR:
								type = TYPE.INSOCKET
							ANIMALS.CROSS:
								pass
					ANIMALS.CROSS:
						match node.animal_type:
							ANIMALS.CUBE:
								type = TYPE.INSOCKET
							ANIMALS.CIRCLE:
								pass
							ANIMALS.LOSANGE:
								pass
							ANIMALS.STAR:
								pass
							ANIMALS.CROSS:
								type = TYPE.INSOCKET
