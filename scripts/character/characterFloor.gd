extends State
class_name CharacterFloor

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var Mspeed: float
var Rspeed: float

func Enter():
	print('floor')

func Physics_Update(_delta: float):
	stateValidation(_delta)
	updateVariables()
	move()
	player.fall()
	
	
func stateValidation(_delta: float):
	if !player.is_on_floor():
		Transitioned.emit(self, "air")
		return
	
	for key in player.dashProc:
		if(player.dashProc[key] > _delta):
			player.dashProc[key] -= _delta
		else:
			player.dashProc[key] = 0
			
		if player.dashProc[key] > player.dashThreshold:
			Transitioned.emit(self, "dash")
		
func updateVariables():
	Mspeed = player.move_speed
	Rspeed = player.run_speed
	
	
func move():
	if Input.is_action_pressed("right"):
		animation.play("walk")
		animation.flip_h = false
		isRunning(1)
	elif Input.is_action_pressed("left"):
		animation.play("walk")
		animation.flip_h = true
		isRunning(-1)
	else:
		animation.play("idle")
		
	if Input.is_action_just_pressed("jump"):
		player.jump()
		
	if Input.is_action_just_pressed("right"):
		player.dashProc.right += 1
		player.dashProc.left = 0
		pass
	if Input.is_action_just_pressed("left"):
		player.dashProc.right = 0
		player.dashProc.left += 1
		pass
	
	
func isRunning(direction: int):
	if Input.is_action_pressed("run"):
		player.velocity.x = player.getLerp(Rspeed * direction, 0.9)
		animation.speed_scale = 1.5
	else:
		player.velocity.x = player.getLerp(Mspeed * direction, 0.9)
		animation.speed_scale = 1
