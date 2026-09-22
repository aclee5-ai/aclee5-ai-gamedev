extends PathFollow2D

@export var swim_speed: float = 100.0
var direction: int = 1

# This dynamically grabs whatever fish child scene you placed inside this node
@onready var fish_node = get_child(0)

func _process(delta):
	# Push this node forward or backward along the track line
	progress += direction * swim_speed * delta
	
	# Turn around automatically when reaching the boundaries of the track
	if progress_ratio >= 1.0 and direction == 1:
		direction = -1
		flip_sprite(true)
	elif progress_ratio <= 0.0 and direction == -1:
		direction = 1
		flip_sprite(false)

func flip_sprite(should_flip: bool):
	if fish_node != null:
		# Check if your fish node has a Sprite2D inside it to flip
		var sprite = fish_node.get_node_or_null("Sprite2D")
		if sprite:
			sprite.flip_h = should_flip
