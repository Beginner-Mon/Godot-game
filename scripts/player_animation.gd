extends Node2D

@export var animation_tree: AnimationTree
@export var player : CharacterBody2D = get_owner()

var last_facing_direction = Vector2(0,-1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var idle = !player.velocity
	
	if !idle:
		last_facing_direction = player.velocity.normalized()

	
	animation_tree.set("parameters/idle/BlendSpace2D/blend_position", last_facing_direction)
	animation_tree.set("parameters/run/BlendSpace2D/blend_position", last_facing_direction)
		
