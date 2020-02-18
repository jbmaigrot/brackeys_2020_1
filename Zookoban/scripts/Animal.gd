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
		animal_type  = ANIMALS.CUBE
	
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
		if node.type == TYPE.SOCKET and node.animal_type == animal_type:
				if grid.world_to_map(node.position) == grid.world_to_map(self.position):
					type = TYPE.INSOCKET
