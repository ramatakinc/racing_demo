tool
extends EditorScenePostImport

func post_import(_scene):
	var i = find_mesh_instance(_scene)
	print(i)
	
	print(i.mesh)
	_scene.mesh = i.mesh

	for n in _scene.get_children():
		n.free()
	
	_scene.create_convex_collision()
	
	for n in _scene.get_children():
		print(n)
		n.set_owner(_scene)
		for l in n.get_children():
			print(l)
			l.set_owner(_scene)
		
	print(_scene)
	return _scene
	
func find_mesh_instance(node):
	for n in node.get_children():
		if n is MeshInstance:
			return n
		
		return find_mesh_instance(n)
