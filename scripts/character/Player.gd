extends CharacterBody2D

signal UseSkill

@export var move_speed: int = 400.0
@export var run_speed: int = 400.0
@export var jump_force: int = -1000
@export var doubleJump: bool = true
@export var skills: Dictionary = {"dash": 5}
@export var dashSpeed: float = 2000.0
@export var mainTimer: Control

var gravity = 65
var direction: int = 1
var dashTimer: float = 0;
var firstJump: bool = false
var doubleJumped: bool = false
var isDamaged: bool = false

func _ready():
	UseSkill.connect(dash)

func _physics_process(delta):
	if dashTimer > delta:
		dashTimer -= delta
	else:
		dashTimer = 0


func fall():
	if !isDamaged:
		velocity.y += gravity
		move_and_slide()
		velocity.x = lerp(velocity.x, .0, 0.2)


func getLerp(speed, weight):
	return lerp(velocity.x, speed, weight)


func jump():
	velocity.y = jump_force


func dash():
	UseSkill.emit("dash")


func _on_fall_zone_body_entered(body):
	#get_tree().reload_current_scene()
	onTakeDamage(body)
	


func onTakeDamage(body):
	isDamaged = true
	$PlayerAnimation.scale.x = 7
	$PlayerAnimation.scale.y = 7
	$PlayerAnimation.play("dead")
	$DeathTimer.start()
	mainTimer._stop()


func _on_death_timer_timeout():
	$PlayerAnimation.scale.x = 1
	$PlayerAnimation.scale.y = 1
	isDamaged = false
	mainTimer._start()
	mainTimer._decreaseTimer();
	if Checkpoint.last_position:
		self.global_position = Checkpoint.last_position
