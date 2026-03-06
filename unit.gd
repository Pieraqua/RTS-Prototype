extends CharacterBody2D

class_name Unit
@export var SPEED = 500

var animated_sprite_2d : AnimatedSprite2D
var target_pos : Vector2
var walking : bool = false

func _ready():
	target_pos = global_position

func _physics_process(_delta):
	if walking:
		velocity = (target_pos - global_position).normalized() * SPEED
		move_and_slide()
	
	if (target_pos - global_position).length() < SPEED*_delta:
		walking = false
		animated_sprite_2d.stop()
		

func walk_towards(pos : Vector2):
	target_pos = pos
	walking = true
	animated_sprite_2d.play('default')
