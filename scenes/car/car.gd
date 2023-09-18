extends VehicleBody

export var steer = 0
export var max_torque = 500
export var max_rpm = 500

func _physics_process(delta):
	steer = lerp(steer, Input.get_axis("right", "left") * 0.4, 5 * delta)
	steering = steer
	
	var acceleration = Input.get_axis("brake", "accelerate")
	var left_rpm = abs($Wheel_Back_Left.get_rpm())
	$Wheel_Back_Left.engine_force = acceleration * max_torque * ( 1 - left_rpm / max_rpm )

	var right_rpm = abs($Wheel_Back_Right.get_rpm())
	$Wheel_Back_Right.engine_force = acceleration * max_torque * ( 1 - right_rpm / max_rpm )

	if Input.is_action_pressed("handbrake"):
		brake = 10
	else:
		brake = 0
