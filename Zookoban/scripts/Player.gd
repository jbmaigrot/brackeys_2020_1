extends KinematicBody2D

var direction = Vector2();
var velocity = Vector2();

const TOP = Vector2(0, -1);
const RIGHT = Vector2(1, 0);
const DOWN = Vector2(0, 1);
const LEFT = Vector2(-1, 0);

var speed = 0;

const MAXSPEED = 128;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	var is_moving = Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_left");
	
	if is_moving:
		speed = MAXSPEED
		if Input.is_action_just_pressed("move_up"):
			direction = TOP
		elif Input.is_action_just_pressed("move_right"):
			direction = RIGHT
		elif Input.is_action_just_pressed("move_down"):
			direction = DOWN
		elif Input.is_action_just_pressed("move_left"):
			direction = LEFT
	else:
		speed = 0;
		
	velocity = speed * direction;
	
	move_and_collide(velocity);
