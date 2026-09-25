extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.has_method("die") or body.name.contains("Player") or body.name.contains("playa"):
		print("Player fell in a hole! Triggering die loop...")
		body.die()
