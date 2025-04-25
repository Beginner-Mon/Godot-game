extends State
class_name PlayerIdle

@export var player: CharacterBody2D
@export var SPEED: float
@export var animation_tree: AnimationTree

func Enter():
	print("Entered Idle State")
	if animation_tree:
		animation_tree.set("parameters/is_moving", false)  # Ensure Idle animation
	if player:
		player.velocity = Vector2.ZERO  # No movement in Idle
func Exit():
	pass
func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if Input.is_action_just_pressed("left_click"):
		Transitioned.emit(self, "run")
