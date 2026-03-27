extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.score += 1
		body._update_UI()
		queue_free()
