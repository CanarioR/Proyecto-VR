@tool
extends EditorScript

# Este script añade StaticBody3D y CollisionShape3D a todos los MeshInstance3D
# del escenario importado de Blender para permitir la detección de colisiones
# necesaria para el sistema de teleportación.

func _run():
	var root = get_scene()
	add_collisions_recursive(root)
	print("Colisiones añadidas al escenario")

func add_collisions_recursive(node: Node):
	# Si es un MeshInstance3D y no tiene ya un StaticBody3D como padre
	if node is MeshInstance3D:
		var parent = node.get_parent()
		if parent and not parent is StaticBody3D:
			add_collision_to_mesh(node)
	
	# Recursivamente procesar todos los hijos
	for child in node.get_children():
		add_collisions_recursive(child)

func add_collision_to_mesh(mesh_instance: MeshInstance3D):
	# Crear StaticBody3D
	var static_body = StaticBody3D.new()
	static_body.name = mesh_instance.name + "_CollisionBody"
	
	# Crear CollisionShape3D
	var collision_shape = CollisionShape3D.new()
	collision_shape.name = "CollisionShape"
	
	# Crear shape desde el mesh
	var mesh = mesh_instance.mesh
	if mesh:
		var shape = mesh.create_trimesh_shape()
		if shape:
			collision_shape.shape = shape
	
	# Reorganizar la jerarquía
	var parent = mesh_instance.get_parent()
	var mesh_index = mesh_instance.get_index()
	
	parent.remove_child(mesh_instance)
	parent.add_child(static_body)
	static_body.set_owner(get_scene())
	static_body.move_to_front()
	
	static_body.add_child(mesh_instance)
	mesh_instance.set_owner(get_scene())
	
	static_body.add_child(collision_shape)
	collision_shape.set_owner(get_scene())
	
	# Restaurar la posición en la jerarquía
	parent.move_child(static_body, mesh_index)
