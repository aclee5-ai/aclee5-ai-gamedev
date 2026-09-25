extends PathFollow2D

@export var swim_speed: float = 45.0
var direction: int = 1

@onready var fish_node = get_child(0)

func _process(delta):
	progress += direction * swim_speed * delta
	
	if progress_ratio >= 1.0 and direction == 1:
		direction = -1
	elif progress_ratio <= 0.0 and direction == -1:
		direction = 1
