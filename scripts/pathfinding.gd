extends Node2D

@export var character: CharacterBody2D
@export var nav_agent : NavigationAgent2D
@export var SPEED: float
@export var stoping_threshold : float = 10


func _ready() -> void:
	nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)



func _physics_process(delta: float) -> void:
	if not nav_agent.is_navigation_finished():
		var next_path_position: Vector2 = nav_agent.get_next_path_position()
		var direction: Vector2 = character.global_position.direction_to(next_path_position)
		var distance = character.global_position.distance_to(next_path_position)
		
		var new_velocity = direction * SPEED * 60
		
		if nav_agent.avoidance_enabled:
			nav_agent.set_velocity(new_velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(new_velocity)
		if new_velocity.length() <= stoping_threshold or distance <= nav_agent.path_desired_distance:
			character.velocity = Vector2.ZERO
	else:
		character.velocity = Vector2.ZERO

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	character.velocity = safe_velocity
