extends TextureButton


func _ready():
	$Label.hide()
	$TextureProgressBar.value = 0
	$TextureProgressBar.texture_progress = texture_normal


func _process(delta):
	pass
