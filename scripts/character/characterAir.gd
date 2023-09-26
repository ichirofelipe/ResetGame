extends State
class_name CharacterAir

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var velX: float
var Mspeed: float
var Rspeed: float

func Enter():
	if player.doubleJump:
		player.doubleJumped = false

	
func Physics_Update(_delta: float):
	stateValidation(_delta)
	updateVariables()
	air()
	player.fall()
	

func stateValidation(_delta: float):
	if player.is_on_floor():
		Transitioned.emit(self, "floor")
		return


func updateVariables():
	velX = player.velocity.x
	Mspeed = player.move_speed
	Rspeed = player.run_speed


func air():
	animation.play("air")
	
	if Input.is_action_pressed("right"):
		player.velocity.x = player.getLerp(Mspeed, 0.9) if velX < Mspeed else player.getLerp(Rspeed, 0.7)
		animation.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = player.getLerp(-Mspeed, 0.9) if velX > -Mspeed else player.getLerp(-Rspeed, 0.7)
		animation.flip_h = true
	
	if Input.is_action_just_pressed("jump") and player.doubleJump and !player.doubleJumped:
		player.jump()
		player.doubleJumped = true
