extends Area2D

@export var camera: Camera2D

func _on_body_entered(body):
	camera.enabled = true

func _on_body_exited(body):
	camera.enabled = false
