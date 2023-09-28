extends TextureButton

@export var player: CharacterBody2D
@export var skillName: String

var cooldown = 0
var isCooldown = false

func _ready():
	cooldown = player.skills[skillName]
	
	$Label.hide()
	$TextureProgressBar.value = 0
	$Timer.wait_time = cooldown
	set_process(false)

func _process(delta):
	$Label.text = "%0.1f" % $Timer.time_left
	$TextureProgressBar.value = int(($Timer.time_left/cooldown) * 100)
	pass


func _on_timer_timeout():
	isCooldown = false
	$Label.hide()
	$TextureProgressBar.value = 0
	set_process(false)


func _on_player_use_skill(skill):
	if !isCooldown:
		isCooldown = !isCooldown
		$Label.show()
		$Timer.start()
		set_process(true)
