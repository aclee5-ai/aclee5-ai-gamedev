extends Area2D


# Called when the node enters the scene tree for the first time.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.is_hidden = true
		# Optional: Lower player opacity slightly to show they are hidden
		body.modulate.a = 0.6 

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.is_hidden = false
		body.modulate.a = 1.0 # Return to full visibility
