extends CharacterBody2D

@onready var hitbox = get_node_or_null("Hitbox")

func _ready():
	# Safely connect the damage sensor when the game starts
	if hitbox != null:
		hitbox.body_entered.connect(_on_hitbox_body_entered)
	else:
		print("ERROR: Could not find a child node named 'Hitbox' under the Predator!")

func _on_hitbox_body_entered(body):
	# The exact moment the shrimp touches this fish, reset the level!
	if body.name == "Player" or body.has_method("handle_movement"):
		print("The shrimp was caught! Resetting level...")
		get_tree().reload_current_scene()
