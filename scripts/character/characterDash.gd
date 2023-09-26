extends State
class_name CharacterDash

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var canDash: bool
var direction: int

func Enter():
	canDash = true
	$DashLength.start()
	
	for key in player.dashProc:
		if player.dashProc[key] > player.dashThreshold:
			direction = 1 if key == "right" else -1
			
		player.dashProc[key] = 0

func Physics_Update(_delta: float):
	stateValidation()
	dash()
	player.fall()
	
	
func stateValidation():
	if canDash:
		return
	
	if player.is_on_floor():
		Transitioned.emit(self, "floor")
	elif !player.is_on_floor():
		Transitioned.emit(self, "air")


func dash():
	animation.play("dash")
	
	if canDash:
		player.velocity.x = player.getLerp(player.dashSpeed * direction, 0.9)
	else:
		player.velocity.x = player.getLerp(.0, 0.9)


func _on_dash_length_timeout():
	canDash = false
