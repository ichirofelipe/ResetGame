extends Control

@export var time = 60
@export var timePenalty = 3;
var minute = 0
var seconds = 0
var miliseconds = 0


func _setTimer(delta): 
	#$Label.text = str(minute) + ":" + str(seconds) + ":" + str("%.2f" % $Timer.time_left)
	miliseconds = fmod(time, 1) * 1000
	seconds = fmod(time, 60)
	minute = fmod(time, 60*60) / 60
	
	var timeleft =  "%02d : %02d : %02d" % [minute, seconds, miliseconds]
	$Label.text = timeleft
	
	time -= delta
func _physics_process(delta):
	_setTimer(delta)
	_gameOver()
	
func _decreaseTimer(): 
	time -= timePenalty;
	
	
func _gameOver():
	if(time <= 0):
		get_tree().change_scene_to_file("res://scenes/levels/tutorial/tutorial.tscn")


func _stop():
	set_process(false)
	

func _start():
	set_process(true)
