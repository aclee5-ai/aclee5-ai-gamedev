extends Area2D

# Type the exact file path of the next level you want to load!
@export var next_level_path: String = "res://scene/Level_3.tscn"

# This variable tracks whether the exit portal is actively open
var is_unlocked: bool = false

@onready var anim_sprite = get_node_or_null("AnimatedSprite2D")

func _ready():
	# Connect the sensor to detect when the shrimp swims inside
	body_entered.connect(_on_body_entered)
	
	# Start the level with the whirlpool hidden and completely disabled
	visible = false
	is_unlocked = false
	$CollisionShape2D.disabled = true

# This function is called remotely by Level 1 when all items are collected!
func unlock_exit():
	is_unlocked = true
	visible = true
	$CollisionShape2D.disabled = false
	
	if anim_sprite:
		anim_sprite.play() # Starts your little whirlpool animation!
	print("The whirlpool has opened! Escape to the next depth.")

func _on_body_entered(body):
	# If the exit is open and the shrimp touches it, advance to the next level scene!
	if is_unlocked and body.has_method("add_item"):
		print("Level complete! Loading next level...")
		get_tree().change_scene_to_file(next_level_path)
