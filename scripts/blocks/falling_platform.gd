extends CharacterBody2D

@onready var anim = get_node("AnimationPlayer");
	
var willFall = false
var isFalling = false;
var motion = Vector2(0,0)
var timer = Timer.new()
var fallTimer = Timer.new()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var FALL_SPEED = 50

func _physics_process(delta):
	_fall(delta)

func _on_area_2d_body_entered(body):
	if body.get_collision_layer() == 1 && !willFall:
		anim.play("shake")
		willFall = true
		_fallCountDownStart()
		print("enter");
				
func _on_destroy():
		willFall = false
		isFalling = false
		queue_free()
		print("im free")
		
func _fall(delta):
	if isFalling:
		print("fall")
		anim.stop();
		velocity.y += (gravity * FALL_SPEED) * delta
		move_and_slide()

func _fallingCountDownStart():
	if isFalling:
		fallTimer.timeout.connect(self._on_destroy)
		fallTimer.wait_time = 4
		fallTimer.one_shot = true
		add_child(fallTimer)
		fallTimer.start()
	
func _fallCountDownStart():
	if willFall:
		timer.timeout.connect(self._on_timer_timeout)
		timer.wait_time = 2
		timer.one_shot = true
		add_child(timer)
		timer.start()

		
func _on_timer_timeout():
		isFalling = true;
		_fallingCountDownStart()
		get_node("CollisionPolygon2D").disabled = true
