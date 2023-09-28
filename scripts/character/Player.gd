extends CharacterBody2D

@export var move_speed: int = 250.0
@export var run_speed: int = 400.0
@export var jump_force: int = -1000
@export var dash_cooldown: int = 5

const GRAVITY = 65

var direction: int = 1
var dashSpeed: float = 1500.0
var dashTimer: float = 0;
var doubleJump: bool = true
var doubleJumped: bool = false

func _physics_process(delta):
	if dashTimer > delta:
		dashTimer -= delta
	else:
		dashTimer = 0


func fall():
	velocity.y += GRAVITY
	move_and_slide()
	velocity.x = lerp(velocity.x, .0, 0.2)


func getLerp(speed, weight):
	return lerp(velocity.x, speed, weight)


func jump():
	velocity.y = jump_force


func _on_fall_zone_body_entered(body):
	get_tree().reload_current_scene()
