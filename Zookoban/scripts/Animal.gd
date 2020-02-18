extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, STAR, CROSS}

var animal_type

var sprite

# Animals
onready var spr_cube = preload("res://sprites/proto/crate_02.png")
onready var spr_circle = preload("res://sprites/proto/crate_03.png")
onready var spr_losange = preload("res://sprites/proto/crate_04.png")
onready var spr_star = preload("res://sprites/proto/crate_05.png")
onready var spr_cross = preload("res://sprites/proto/crate_06.png")

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

func end_move():
	.end_move()
	for node in grid.get_children():
		if node.type == TYPE.SOCKET and node.animal_type == animal_type:
				if grid.world_to_map(node.position) == grid.world_to_map(self.position):
					type = TYPE.INSOCKET
