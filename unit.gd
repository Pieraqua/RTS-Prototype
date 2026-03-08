extends CharacterBody2D

class_name Unit
@export var SPEED = 500
@onready var nav = $NavigationAgent2D

var animated_sprite_2d : AnimatedSprite2D
var target_pos : Vector2
var walking : bool = false

func _ready():
	target_pos = global_position

func _physics_process(_delta):
	_move()

func walk_towards(pos : Vector2):
	target_pos = pos
	nav.target_position = pos
	walking = true
	animated_sprite_2d.play('default')

func _move() -> void:
	
	if nav.is_navigation_finished():
		walking = false
		animated_sprite_2d.stop()
		return
	
	# Get pathfinding information
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav.get_next_path_position()

	# Calculate the new velocity
	var new_velocity = current_agent_position.direction_to(next_path_position) * SPEED

	# Set correct velocity
	if nav.avoidance_enabled:
		nav.set_velocity(new_velocity)
	else:
		_velocity_computed(new_velocity)

	# Do the movement
	move_and_slide()

func _velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	
