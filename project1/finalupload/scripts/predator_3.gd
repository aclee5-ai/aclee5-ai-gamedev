extends CharacterBody2D

@onready var hitbox = get_node_or_null("Hitbox")

func _ready():
	if hitbox != null:
		hitbox.body_entered.connect(_on_hitbox_body_entered)
	else:
		print("ERROR: Could not find a child node named 'Hitbox' under the Predator!")

func _on_hitbox_body_entered(body):
	if body.has_method("die"):
		body.die()
