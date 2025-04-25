extends CharacterBody2D
class_name NPC

signal reached_target

@export var navigation: NavigationAgent2D
@export var stats: NPCstat
@onready var animated_sprites: AnimatedSprite2D = $AnimatedSprite2D


var target_position: Vector2 = Vector2.ZERO
func _ready() -> void:
	animated_sprites.sprite_frames = stats.texture
	
	
	navigation.target_reached.connect(_on_navigation_agent_2d_target_reached)
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func move_to(new_position: Vector2) -> void:
	target_position = new_position
	navigation.set_target_position(new_position)


func _on_navigation_agent_2d_target_reached() -> void:
	emit_signal("reached_target")
