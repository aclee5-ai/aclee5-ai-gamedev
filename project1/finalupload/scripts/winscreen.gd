extends Node2D

@onready var congrats = get_node_or_null("congratulations")

func _ready() -> void:
	if congrats != null:
		congrats.play()

func _process(_delta):
	if congrats != null:
		congrats.play()
	if Input.is_action_just_pressed("ui_accept"):
		print("Returning to main menu...")
		get_tree().change_scene_to_file("res://scene/main.tscn") 
