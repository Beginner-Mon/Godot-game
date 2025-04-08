extends CharacterBody2D

# Constants
const SPEED := 300.0
const STOP_THRESHOLD := 5.0  # Distance to stop moving

# Variables
var target_position := Vector2.ZERO  # Where to move
var should_move := false            # Toggle movement
@onready var sprite_scene := preload("res://scene/postman.tscn")  # Preloaded sprite scene
var last_sprite_spawn_distance := 50.0  # Minimum distance to spawn new sprites
@onready var anim := $AnimatedSprite2D  # Reference to AnimatedSprite2D node
var facing_right := true                # Track side direction for flipping

func _input(event: InputEvent) -> void:
	# Handle left mouse click to set target
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = get_global_mouse_position()
		should_move = true

func _physics_process(delta: float) -> void:
	# Apply gravity if not on floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Move toward target and update animation
	if should_move:
		var current_position := global_position
		var distance_to_target := current_position.distance_to(target_position)

		# Stop if close enough
		if distance_to_target < STOP_THRESHOLD:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			should_move = false
			_update_animation("idle", current_position, target_position)
		else:
			# Move in direction of target
			var direction := (target_position - current_position).normalized()
			velocity.x = direction.x * SPEED
			
			# Update animation based on movement
			_update_animation("run", current_position, target_position)
			
			# Generate sprites based on distance
			_generate_sprites(current_position, target_position, distance_to_target)

	# Decelerate and set idle when not moving
	if not should_move:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_update_animation("idle", global_position, target_position)

	move_and_slide()

func _update_animation(state: String, current_pos: Vector2, target_pos: Vector2) -> void:
	# Determine direction based on target relative to current position
	var direction := (target_pos - current_pos).normalized()
	
	# Choose animation based on direction and state (idle/run)
	var anim_name := ""
	if abs(direction.y) > abs(direction.x):  # Vertical movement dominates
		if direction.y > 0:  # Moving down (front)
			anim_name = "front_" + state
		else:  # Moving up (back)
			anim_name = "back_" + state
	else:  # Horizontal movement dominates
		anim_name = "side_" + state
		# Flip sprite based on horizontal direction
		facing_right = direction.x > 0
		anim.flip_h = not facing_right  # Flip if moving left

	# Play the selected animation
	if anim.animation != anim_name:
		anim.play(anim_name)

func _generate_sprites(current_pos: Vector2, target_pos: Vector2, distance: float) -> void:
	if distance > last_sprite_spawn_distance:
		var distance_x := target_pos.x - current_pos.x
		var distance_y := target_pos.y - current_pos.y

		if abs(distance_x) > last_sprite_spawn_distance:
			_spawn_sprite(current_pos + Vector2(distance_x / 2, 0))
		if abs(distance_y) > last_sprite_spawn_distance:
			_spawn_sprite(current_pos + Vector2(0, distance_y / 2))

		last_sprite_spawn_distance = distance

func _spawn_sprite(spawn_pos: Vector2) -> void:
	var sprite_instance := sprite_scene.instantiate()
	sprite_instance.position = spawn_pos
	get_parent().add_child(sprite_instance)
