extends PathFollow2D

@export var swim_speed: float = 60.0
var anim_sprite: AnimatedSprite2D

func _ready():
	await get_tree().process_frame

	anim_sprite = _find_animated_sprite(self)

	if anim_sprite != null:
		rotates = false
		loop = true
		anim_sprite.play("swim")
		anim_sprite.flip_h = false

func _find_animated_sprite(node: Node) -> AnimatedSprite2D:
	for child in node.get_children():
		if child is AnimatedSprite2D:
			return child
		var found = _find_animated_sprite(child)
		if found:
			return found
	return null

func _process(delta):
	progress += swim_speed * delta

	if anim_sprite != null:
		anim_sprite.flip_h = progress_ratio > 0.5
