extends KinematicBody2D

enum {EMPTY, PLAYER, ANIMAL, OBSTACLE, COLLECTIBLE}

var direction = Vector2();
var target_direction = Vector2()
var world_target_pos = Vector2()
var is_moving = false

var type

var velocity = Vector2();

var speed = 0;

const MAXSPEED = 1000;

var grid

func _ready():
	grid = get_parent()
	set_process(true)


func move(dir):
	
	var pos_translation =  grid.grid_move(self, dir) - position
	move_and_collide(pos_translation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
