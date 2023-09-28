extends Control

var seconds = 0
var minute = 0
var defaultSecs = 0
var defaultMins = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	_resetTimer()




func _initTimer(): 
	$Label.text = str(minute) + ":" + str(seconds)
	
func _on_timer_timeout():
	if seconds == 0:
		if minute > 0:
			minute -= 1
			seconds = 60
	seconds -= 1
	_initTimer();
	
		
func _resetTimer():
	seconds = defaultSecs
	minute = defaultMins
	_initTimer()
	

