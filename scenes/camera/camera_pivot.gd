extends Spatial

var current_direction = Vector3.FORWARD
export (float, 1, 10, 0.1) var smoothing = 2.5

func _physics_process(delta):
	var current_velocity = get_parent().get_linear_velocity()
	current_velocity.y = 0
	if current_velocity.length_squared() > 1:
		current_direction = lerp(current_direction, current_velocity.normalized(), smoothing * delta)
		
	var look_direction = current_direction.normalized()
	var x = look_direction.cross(Vector3.UP)
	
	global_transform.basis = Basis(x, Vector3.UP, -look_direction)
