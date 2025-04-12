extends CharacterBody2D

var SPEED := 300.0  # Use float for smoother calculations
var target_position := Vector2.ZERO
var is_moving := false

@onready var anim_tree = $AnimationTree  # Shorthand for get_node("AnimationTree")

func _physics_process(delta: float) -> void:
	# Check for left click input
	if Input.is_action_just_pressed("left_click"):
		target_position = get_global_mouse_position()
		is_moving = true
	
	# If we have a target and are moving
	if is_moving:
		# Calculate direction to target
		var direction = (target_position - global_position).normalized()
		var distance = global_position.distance_to(target_position)
		
		# Move towards target with delta for frame-rate independence
		velocity = direction * SPEED * delta * 60  # 60 approximates a standard frame rate
		
		# Update animation
		if distance > 5:  # Small threshold to prevent jittering
			anim_tree.get("parameters/playback").travel("run")
			anim_tree.set("parameters/idle/BlendSpace2D/blend_position", direction)
			anim_tree.set("parameters/run/BlendSpace2D/blend_position", direction)
		else:
			# Stop when close enough to target
			is_moving = false
			velocity = Vector2.ZERO
			anim_tree.get("parameters/playback").travel("idle")
	else:
		velocity = Vector2.ZERO
		anim_tree.get("parameters/playback").travel("idle")
	
	move_and_slide()
