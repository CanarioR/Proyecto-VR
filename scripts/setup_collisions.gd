extends Node3D

# Script para añadir colisiones automáticamente al escenario de Blender
# Añade este script temporalmente al nodo EscenarioPrincipal en el editor,
# ejecuta la escena, y las colisiones se añadirán automáticamente

func _ready():
	add_collisions_to_children(self)
	print("Colisiones añadidas al escenario")

func add_collisions_to_children(node: Node):
	for child in node.get_children():
		if child is MeshInstance3D:
			add_collision_to_mesh(child)
		
		# Recursivamente procesar hijos
		if child.get_child_count() > 0:
			add_collisions_to_children(child)

func add_collision_to_mesh(mesh_instance: MeshInstance3D):
	# Verificar si ya tiene un StaticBody3D como hijo
	for child in mesh_instance.get_children():
		if child is StaticBody3D:
			return  # Ya tiene colisión
	
	# Crear StaticBody3D
	var static_body = StaticBody3D.new()
	static_body.name = "CollisionBody"
	
	# Crear CollisionShape3D
	var collision_shape = CollisionShape3D.new()
	collision_shape.name = "CollisionShape"
	
	# Crear shape desde el mesh
	var mesh = mesh_instance.mesh
	if mesh:
		var shape = mesh.create_trimesh_shape()
		if shape:
			collision_shape.shape = shape
			
			# Añadir a la jerarquía
			mesh_instance.add_child(static_body)
			static_body.add_child(collision_shape)
			
			print("Colisión añadida a: ", mesh_instance.name)
