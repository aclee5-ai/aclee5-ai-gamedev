extends Area2D

@export var next_level_path: String = "res://scene/Level_3.tscn"

var is_unlocked: bool = false

@onready var anim_sprite = get_node_or_null("AnimatedSprite2D")

func _ready():
	body_entered.connect(_on_body_entered)
	
	visible = false
	is_unlocked = false
	$CollisionShape2D.disabled = true

func unlock_exit():
	is_unlocked = true
	visible = true
	$CollisionShape2D.disabled = false
	
	if anim_sprite:
		anim_sprite.play()
	print("The whirlpool has opened! Escape to the next depth.")

func _on_body_entered(body):
	if is_unlocked and body.has_method("add_item"):
		print("Level complete! Loading next level...")
		get_tree().change_scene_to_file(next_level_path)
