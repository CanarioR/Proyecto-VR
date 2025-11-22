extends Node3D

# Este script agrega colisiones automáticamente a todos los MeshInstance3D
# Ejecuta esto una vez para generar las colisiones del escenario

func _ready():
	print("=== Generando colisiones para el escenario ===")
	add_collisions_recursive(self)
	print("✓ Colisiones generadas")

func add_collisions_recursive(node: Node):
	# Recorrer todos los hijos
	for child in node.get_children():
		# Si es un MeshInstance3D, agregar colisión
		if child is MeshInstance3D and child.mesh != null:
			# Verificar si ya tiene un StaticBody3D padre o hijo
			var has_collision = false
			
			# Verificar padre
			if child.get_parent() is StaticBody3D or child.get_parent() is CollisionShape3D:
				has_collision = true
			
			# Verificar hijos
			for grandchild in child.get_children():
				if grandchild is StaticBody3D or grandchild is CollisionShape3D:
					has_collision = true
					break
			
			# Si no tiene colisión, agregarla
			if not has_collision:
				print("Agregando colisión a: ", child.name)
				child.create_trimesh_collision()
		
		# Recursión para procesar hijos
		add_collisions_recursive(child)
