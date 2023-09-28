extends State
class_name CharacterDash

@export var player: CharacterBody2D
@export var animation: AnimatedSprite2D

var canDash: bool

func Enter():
	canDash = true
	$DashLength.start()
	player.dashTimer = player.skills.dash
	player.dash()
	player.dashSpeed = 0;
	
func Physics_Update(_delta: float):
	stateValidation()
	dash(_delta)
	player.fall()
	
	
func stateValidation():
	if canDash:
		return
	
	if player.is_on_floor():
		Transitioned.emit(self, "floor")
	elif !player.is_on_floor():
		Transitioned.emit(self, "air")


func dash(delta):
	animation.play("dash")
	
	if canDash:
		player.dashSpeed += (100 * delta) * 100
		player.velocity.x = player.getLerp(player.dashSpeed * player.direction, 0.5)
	else:
		player.velocity.x = player.getLerp(.0, 0.9)


func _on_dash_length_timeout():
	canDash = false
	
