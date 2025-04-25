extends State
class_name PlayerMove

@export var player : CharacterBody2D
@export var animation_tree: AnimationTree
@export var SPEED: float = 300

func Enter():
	if animation_tree:
		animation_tree.get("parameters/playback").travel("run")
		
func Exit():
	pass
func Physics_Update(delta: float):
	
	var direction = Vector2.ZERO
	if not Input.is_action_just_pressed("left_click"):
		Transitioned.emit(self, "idle")
	else:
		var mouse_pos = player.get_global_mouse_position()
		direction = (mouse_pos - player.global_position).normalized()
	
	# Set velocity (move_and_slide is called in Player.gd)
	player.velocity = direction * SPEED
		
	if animation_tree and direction != Vector2.ZERO:
		animation_tree.set("parameters/run/BlendSpace2D/blend_position", direction)
