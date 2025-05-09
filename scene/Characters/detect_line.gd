extends RayCast2D

@export var body: CharacterBody2D
@export var ray_length: float = 40
var last_facing_direction = Vector2(0,-1)
var direction = Vector2.ZERO




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var idle = !body.velocity
	
	if !idle: 
		last_facing_direction = body.velocity.normalized()
		
	target_position = last_facing_direction * ray_length
	
