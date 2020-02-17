extends KinematicBody2D

var direction = Vector2();
var target_direction = Vector2()
var world_target_pos = Vector2()
var is_moving = false


var velocity = Vector2();

var speed = 0;

const MAXSPEED = 400;

var grid

# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_parent()
	set_process(true)


func _process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	if not is_moving and direction != Vector2():
		# if player is not moving and has no direction
		# then set the target direction
		target_direction = direction.normalized()

		if grid.is_cell_free(position, direction):
			world_target_pos = grid.update_actor_pos(position, direction)
			is_moving = true

	elif is_moving:
		speed = MAXSPEED
		velocity = speed * target_direction * delta

		var distance_to_target = position.distance_to(world_target_pos)
		var move_distance = velocity.length()

		# Set the last movement distance to the distance to the target
		# this will make the player stop exaclty on the target
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false

		move_and_collide(velocity)
