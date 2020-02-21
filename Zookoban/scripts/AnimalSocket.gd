extends "Actor.gd"

enum ANIMALS {CUBE, CIRCLE, LOSANGE, STAR, CROSS}

var animal_type

var filled

var sprite
var top_sprite

# Animals Socket
onready var spr_cube = preload("res://sprites/holes/H_square.png")
onready var spr_circle = preload("res://sprites/holes/H_circle.png")
onready var spr_losange = preload("res://sprites/holes/H_losange.png")
onready var spr_cross = preload("res://sprites/holes/H_cross.png")

onready var spr_cube_t = preload("res://sprites/holes/H_square_top.png")
onready var spr_circle_t = preload("res://sprites/holes/H_circle_top.png")
onready var spr_losange_t = preload("res://sprites/holes/H_losange_top.png")
onready var spr_cross_t = preload("res://sprites/holes/H_cross_top.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	
	filled = false
	sprite = get_node("Sprite")
	top_sprite = get_node("TopSprite")
	top_sprite.visible = false
	
	type = TYPE.SOCKET
	if (animal_type == null):
		animal_type  = ANIMALS.CUBE
	
	# Define sprite depending on Animal type
	match animal_type:
		ANIMALS.CUBE:
			sprite.texture = spr_cube
			top_sprite.texture = spr_cube_t
		ANIMALS.CIRCLE:
			sprite.texture = spr_circle
			top_sprite.texture = spr_circle_t
		ANIMALS.LOSANGE:
			sprite.texture = spr_losange
			top_sprite.texture = spr_losange_t
		ANIMALS.CROSS:
			sprite.texture = spr_cross
			top_sprite.texture = spr_cross_t

func _process(delta):
	if filled:
		top_sprite.visible = true
