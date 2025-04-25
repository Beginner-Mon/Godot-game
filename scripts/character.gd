extends CharacterBody2D
class_name Player

@export var player_navigation: NavigationAgent2D
var target_position: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		target_position = get_global_mouse_position()
		player_navigation.set_target_position(target_position)
	
	move_and_slide()
