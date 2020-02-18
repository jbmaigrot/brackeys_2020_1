extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, STAR, CROSS}

var animal_type

var sprite

# Animals Socket
onready var spr_cube = preload("res://sprites/proto/crate_27.png")
onready var spr_circle = preload("res://sprites/proto/crate_28.png")
onready var spr_losange = preload("res://sprites/proto/crate_29.png")
onready var spr_star = preload("res://sprites/proto/crate_30.png")
onready var spr_cross = preload("res://sprites/proto/crate_31.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	
	sprite = get_node("Sprite")
	
	type = TYPE.SOCKET
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
