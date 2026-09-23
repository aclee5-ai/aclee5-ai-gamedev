extends CharacterBody2D

# --- Movement Settings ---
@export var walk_speed: float = 100.0
@export var water_drag: float = 15.0         # How fast you slow down mid-air

# --- Underwater Jumping Mechanics ---
@export var tail_snap_force: float = -230.0  # The upwards thrust force
@export var water_gravity: float = 500.0     # Light gravity so you float down gently

# --- Weight Penalty Mechanics ---
var items_collected: int = 0
@export var weight_per_item: float = 8.0       # Adds pulling down force per item
@export var penalty_per_item: float = 2.0       # Subtracts jump height/walk speed per item


func _physics_process(delta):
	# 1. Apply Underwater Gravity & Sinking Weight Force
	var current_gravity = water_gravity + (items_collected * weight_per_item)
	
	if not is_on_floor():
		velocity.y += current_gravity * delta

	# 2. Handle Tail-Snap Jump (Upward Movement)
	var current_jump_force = tail_snap_force + (items_collected * penalty_per_item)
	current_jump_force = min(-100.0, current_jump_force) 
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = current_jump_force

	# 3. Handle Horizontal Skittering (Left / Right Movement)
	var current_walk_speed = max(60.0, walk_speed - (items_collected * penalty_per_item))
	var direction = Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * current_walk_speed
		
		# SAFELY FLIP SPRITE: This looks for any Sprite2D or AnimatedSprite2D child node
		for child in get_children():
			if child is Sprite2D or child is AnimatedSprite2D:
				child.flip_h = (direction < 0)
				
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, walk_speed * 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, water_drag * delta * 100)

	# 4. Execute Godot's physics calculation
	move_and_slide()

# --- Global Interface Functions ---
func add_item():
	items_collected += 1
	print("Shrimp collected an item! Total weight: ", items_collected)
