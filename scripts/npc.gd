extends CharacterBody2D
class_name NPC

signal reached_target

@export var navigation: NavigationAgent2D
@export var stats: NPCstat
@export var target_body: NPC
@export var area : Area2D

@onready var animated_sprites: AnimatedSprite2D = $AnimatedSprite2D

var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	if not stats:
		push_error("NPC stats not assigned!")
		return
	if not navigation:
		push_error("NavigationAgent2D not assigned!")
		navigation.path_desired_distance = 40
		return
	if not animated_sprites:
		push_error("AnimatedSprite2D not assigned!")
		return
	
	animated_sprites.sprite_frames = stats.texture

func _physics_process(delta: float) -> void:
	if not navigation:
		return	
	if target_body and velocity != Vector2.ZERO:
		move_to(target_body.position)

	move_and_slide()

func move_to(new_position: Vector2) -> void:
	target_position = new_position
	navigation.set_target_position(new_position)

func _on_navigation_agent_2d_target_reached() -> void:
	emit_signal("reached_target")

func _on_area_2d_body_entered(body: NPC) -> void:

	if target_body and target_body == body:
		emit_signal("reached_target")
		print(position)
		move_to(position)
		velocity = Vector2.ZERO
func _on_area_2d_body_exited(body: Node2D) -> void:
	if target_body and target_body == body:
		print("ext body")
		move_to(target_body.position)
