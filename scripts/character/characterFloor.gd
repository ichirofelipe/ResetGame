extends State
class_name CharacterFloor

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var Mspeed: float
var Rspeed: float

func Enter():
	player.firstJump = false
	if player.doubleJump:
		player.doubleJumped = false

func Physics_Update(_delta: float):
	stateValidation(_delta)
	updateVariables()
	playerMotion()
	player.fall()
	
	
func stateValidation(_delta: float):
	if !player.is_on_floor():
		Transitioned.emit(self, "air")
		return
		
func updateVariables():
	Mspeed = player.move_speed
	Rspeed = player.run_speed
	
	
func playerMotion():
	if Input.is_action_pressed("right"):
		isMoving(1)
	elif Input.is_action_pressed("left"):
		isMoving(-1)
	else:
		animation.play("idle")
		
	if Input.is_action_just_pressed("dash") and player.dashTimer == 0:
		Transitioned.emit(self, "dash")
		
	if Input.is_action_just_pressed("jump"):
		player.firstJump = true
		player.jump()
	

func isMoving(direction: int):
	player.direction = direction
	animation.play("walk")
	animation.flip_h = true if direction == -1 else false
	isRunning(direction)
	
	
func isRunning(direction: int):
	if Input.is_action_pressed("run"):
		player.velocity.x = player.getLerp(Rspeed * direction, 0.9)
		animation.speed_scale = 1.5
	else:
		player.velocity.x = player.getLerp(Mspeed * direction, 0.9)
		animation.speed_scale = 1
