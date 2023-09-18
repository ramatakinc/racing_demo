extends MultiMeshInstance


# Called when the node enters the scene tree for the first time.
func _ready():
	var shape = multimesh.mesh.create_convex_shape(false, true)
	var physics_body = StaticBody.new()

	for i in range(multimesh.instance_count):
		var collision_shape = CollisionShape.new()
		collision_shape.shape = shape
		collision_shape.transform = multimesh.get_instance_transform(i)
		physics_body.add_child(collision_shape)

	add_child(physics_body)
