extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.has_method("add_item"):
		body.add_item()
		
		var level_node = get_tree().current_scene
		if level_node and level_node.has_method("check_remaining_items"):
			level_node.check_remaining_items()
			
		queue_free() 
