extends State
class_name CharacterAir

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var velX: float
var Mspeed: float
var Rspeed: float

func Enter():
	$AirTimer.start()

	
func Physics_Update(_delta: float):
	stateValidation(_delta)
	updateVariables()
	playerMotion()
	player.fall()
	

func stateValidation(_delta: float):
	if player.is_on_floor():
		$AirTimer.stop()
		Transitioned.emit(self, "floor")
		return


func updateVariables():
	velX = player.velocity.x
	Mspeed = player.move_speed
	Rspeed = player.run_speed


func playerMotion():
	if !player.isDamaged:
		animation.play("air")
	
	if Input.is_action_pressed("right"):
		player.velocity.x = player.getLerp(Mspeed, 0.9) if velX < Mspeed else player.getLerp(Rspeed, 0.7)
		isInAir(1)
	elif Input.is_action_pressed("left"):
		player.velocity.x = player.getLerp(-Mspeed, 0.9) if velX > -Mspeed else player.getLerp(-Rspeed, 0.7)
		isInAir(-1)
		
	if Input.is_action_just_pressed("dash") and player.dashTimer == 0:
		Transitioned.emit(self, "dash")
	
	if Input.is_action_just_pressed("jump"):
		jumpValidation()		


func isInAir(direction: int):
	player.direction = direction
	animation.flip_h = true if direction == -1 else false
	
	
func jumpValidation():
	if !player.firstJump:
		$AirTimer.stop()
		player.jump()
		player.firstJump = true
		
	elif  player.doubleJump and !player.doubleJumped:
		player.jump()
		player.doubleJumped = true
	


func _on_air_timer_timeout():
	player.firstJump = true
