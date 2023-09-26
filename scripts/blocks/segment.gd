extends Area2D

func _on_body_entered(body):
	Segment.last_segment = global_position
	Segment.width_segment = $CollisionShape2D.shape.size
	print($CollisionShape2D.shape.size)
