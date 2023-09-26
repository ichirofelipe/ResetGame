extends CharacterBody2D

@export var move_speed: int = 250.0
@export var run_speed: int = 400.0
@export var jump_force: int = -1000

const GRAVITY = 65

var dashProc: Dictionary = { "right": 0, "left": 0 }
var dashSpeed: float = 1500.0
var dashThreshold: float = 1.7
var doubleJump: bool = true
var doubleJumped: bool = false

func fall():
	velocity.y += GRAVITY
	move_and_slide()
	velocity.x = lerp(velocity.x, .0, 0.2)


func getLerp(speed, weight):
	return lerp(velocity.x, speed, weight)


func jump():
	velocity.y = jump_force
	for key in dashProc:
		dashProc[key] = 0


func _on_fall_zone_body_entered(body):
	get_tree().reload_current_scene()
