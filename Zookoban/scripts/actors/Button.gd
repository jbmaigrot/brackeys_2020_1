extends "Actor.gd"

class_name ActorButton

var active = false

var sprite
var pos

var door_list
var btn_list

onready var spr_but_on = preload("res://sprites/s_but_on.png")
onready var spr_but_off = preload("res://sprites/s_but_off.png")

func _ready():
	._ready()
	sprite = get_node("Sprite")
	pos = grid.world_to_map(position)
	door_list = []



func _process(delta):
#	if door_list == []:
#		for node in grid.get_children():
#			if node is Door:
#				door_list.append(node)
#		print(door_list)
	
	if (grid.grid[pos.x][pos.y] == TYPE.PLAYER or grid.grid[pos.x][pos.y] == TYPE.ANIMAL) and !active:
		# switch_doors(true)
		active = true
		sprite.texture = spr_but_on
	elif grid.grid[pos.x][pos.y] != TYPE.PLAYER and grid.grid[pos.x][pos.y] != TYPE.ANIMAL and active:
		# switch_doors(false)
		active = false
		sprite.texture = spr_but_off
	
func switch_doors(b):
	for door in door_list:
		door.open = b

