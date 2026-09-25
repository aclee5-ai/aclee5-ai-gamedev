extends Control

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scene/level_1.tscn")
