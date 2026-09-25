extends CharacterBody2D

#Movement Settings
@export var walk_speed: float = 60.0
@export var water_drag: float = 15.0

#Underwater Jumping Mechanics
@export var tail_snap_force: float = -150.0  
@export var water_gravity: float = 200.0

#Weight Penalty Mechanics
var items_collected: int = 0
@export var weight_per_item: float = 6.0
@export var penalty_per_item: float = 0.25


@onready var jump_sound = get_node_or_null("JumpSound")

@onready var death_sound = get_node_or_null("DeathSound")
@onready var game_over_ui = get_node_or_null("CanvasLayer/GameOverUI")
@onready var game_over_ui2 = get_node_or_null("CanvasLayer/GameOverUI2")

var is_dead: bool = false

func _physics_process(delta):
	
	if is_dead:
		if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_ENTER):
			get_tree().reload_current_scene()
		return
	var current_gravity = water_gravity + (items_collected * weight_per_item)
	
	if not is_on_floor():
		velocity.y += current_gravity * delta

	var current_jump_force = tail_snap_force + (items_collected * penalty_per_item)
	current_jump_force = min(-100.0, current_jump_force) 
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = current_jump_force
		$AnimatedSprite2D.play("jump")
		if jump_sound != null:
			jump_sound.play()
			
	var current_walk_speed = max(60.0, walk_speed - (items_collected * penalty_per_item))
	var direction = Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * current_walk_speed
		if abs(velocity.x) > abs(velocity.y):
			$AnimatedSprite2D.play("right" if velocity.x < 0 else "left")

				
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, walk_speed * 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, water_drag * delta * 100)

	move_and_slide()

func die():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO 
	
	if death_sound != null:
		death_sound.play()
		
	if game_over_ui != null:
		game_over_ui.visible = true
	if game_over_ui2 != null:
		game_over_ui2.visible = true
	print("Player initiated death screen loop. Waiting for ENTER input...")

func add_item():
	items_collected += 1
	print("Shrimp collected an item! Total weight: ", items_collected)
