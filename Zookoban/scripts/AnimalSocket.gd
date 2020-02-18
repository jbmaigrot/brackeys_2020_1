extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, STAR, CROSS}

var animal_type

var sprite

# Animals Socket
onready var spr_cube = preload("res://sprites/holes/H_square.png")
onready var spr_circle = preload("res://sprites/holes/H_circle.png")
onready var spr_losange = preload("res://sprites/holes/H_losange.png")
onready var spr_star = preload("res://sprites/holes/H_star.png")
onready var spr_cross = preload("res://sprites/holes/H_cross.png")

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
