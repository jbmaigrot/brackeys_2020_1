extends "Actor.gd"

class_name Door

var open = false

var sprite
var pos

onready var spr_door_open = preload("res://sprites/s_door_open.png")
onready var spr_door_closed = preload("res://sprites/s_door_closed.png")

func _ready():
	._ready()
	sprite = get_node("Sprite")
	pos = grid.world_to_map(position)
	type = TYPE.OBSTACLE


func _process(delta):
	if grid.grid[pos.x][pos.y] == TYPE.OBSTACLE and open:
		grid.grid[pos.x][pos.y] == TYPE.EMPTY
		sprite.texture = spr_door_open
	elif grid.grid[pos.x][pos.y] != TYPE.EMPTY and !open:
		grid.grid[pos.x][pos.y] == TYPE.OBSTACLE
		sprite.texture = spr_door_closed
	
