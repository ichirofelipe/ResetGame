extends CharacterBody2D

@onready var anim = get_node("AnimationPlayer");

@export var platformCooldown = 3

var willFall = false
var isFalling = false;
var timer = Timer.new()
var fallTimer = Timer.new()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var FALL_SPEED = 50

var currentPos;
var defaultPos;

func _ready():
	defaultPos = self.global_position
	currentPos = defaultPos;

func _physics_process(delta):
	_fall(delta)

func _on_area_2d_body_entered(body):
	if body.get_collision_layer() == 1 && !willFall:
		anim.play("shake")
		willFall = true
		_fallCountDownStart()
		print("enter");
				
func _on_reset_position():
		willFall = false
		isFalling = false
		get_node("CollisionPolygon2D").disabled = false
		self.global_position = defaultPos;
		velocity.y = 0;
		
func _fall(delta):
	if isFalling:
		print("fall")
		anim.stop();
		velocity.y += (gravity * FALL_SPEED) * delta
		move_and_slide()

func _fallingCountDownStart():
	if isFalling:
		fallTimer.timeout.connect(self._on_reset_position)
		fallTimer.wait_time = platformCooldown
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
