extends Node3D

# Referencias
@onready var xr_camera = $XROrigin3D/XRCamera3D
@onready var xr_origin = $XROrigin3D
@onready var start_button = $UI/StartButton
@onready var exit_button = $UI/ExitButton
@onready var reticle = $XROrigin3D/XRCamera3D/Reticle

# Variables
var xr_interface: XRInterface
var looking_at_button: Node3D = null
var raycast_distance: float = 100.0
var reticle_material: StandardMaterial3D
var start_button_material: StandardMaterial3D
var exit_button_material: StandardMaterial3D

# Variables para control con mouse (modo editor)
var mouse_sensitivity: float = 0.003
var camera_rotation: Vector2 = Vector2.ZERO
var is_mouse_captured: bool = false

func _ready():
	# Esperar un frame
	await get_tree().process_frame
	
	# Inicializar XR
	initialize_xr()
	
	# Crear material del reticle
	if reticle:
		reticle_material = StandardMaterial3D.new()
		reticle_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		reticle_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		reticle_material.albedo_color = Color(1, 1, 1, 0.8)
		reticle.set_surface_override_material(0, reticle_material)
	
	# Guardar materiales originales de los botones
	if start_button and start_button.has_node("MeshInstance3D"):
		var mesh_instance = start_button.get_node("MeshInstance3D")
		start_button_material = mesh_instance.get_surface_override_material(0)
	
	if exit_button and exit_button.has_node("MeshInstance3D"):
		var mesh_instance = exit_button.get_node("MeshInstance3D")
		exit_button_material = mesh_instance.get_surface_override_material(0)
	
	print("=== MENÚ PRINCIPAL VR ===")
	print("Mira un botón y toca la pantalla para seleccionarlo")
	print("Start button existe: ", start_button != null)
	print("Exit button existe: ", exit_button != null)
	print("*** EN EDITOR: Click para capturar mouse, ESC para liberar ***")

func initialize_xr():
	# NO inicializar XR si estamos en el editor (para poder usar mouse)
	if OS.has_feature("editor"):
		print("⚠ Modo EDITOR detectado - VR deshabilitado, usando controles de mouse")
		xr_interface = null
		return
	
	xr_interface = XRServer.find_interface("Native mobile")
	
	if not xr_interface and XRServer.get_interface_count() > 0:
		xr_interface = XRServer.get_interface(0)
	
	if xr_interface:
		if not xr_interface.is_initialized():
			xr_interface.initialize()
		
		get_viewport().use_xr = true
		print("✓ VR inicializado")
	else:
		print("⚠ VR no disponible - Usando modo editor con mouse")

func _process(_delta):
	# Control de cámara con mouse en editor
	if not xr_interface or not xr_interface.is_initialized():
		# Aplicar rotación de mouse a la cámara
		xr_camera.rotation.y = -camera_rotation.x
		xr_camera.rotation.x = -camera_rotation.y
		xr_camera.rotation.x = clamp(xr_camera.rotation.x, -PI/2, PI/2)
	
	# Raycast desde la cámara para detectar qué botón estamos mirando
	var space_state = get_world_3d().direct_space_state
	var camera_transform = xr_camera.global_transform
	
	var from = camera_transform.origin
	var to = from - camera_transform.basis.z * raycast_distance
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var result = space_state.intersect_ray(query)
	
	var current_button = null
	if result and result.collider:
		print("Raycast hit: ", result.collider.name, " (", result.collider.get_class(), ")")
		
		# El collider puede ser directamente el StaticBody3D o un hijo
		if result.collider is StaticBody3D:
			# Es el botón directamente
			current_button = result.collider
			print("✓ Botón detectado directamente: ", current_button.name)
		else:
			# Es un hijo, obtener el padre
			var collider_parent = result.collider.get_parent()
			print("Padre del collider: ", collider_parent.name if collider_parent else "null")
			if collider_parent == start_button or collider_parent == exit_button:
				current_button = collider_parent
				print("✓ Botón detectado por padre: ", current_button.name)
	
	# Actualizar qué botón estamos mirando
	if current_button != looking_at_button:
		# Resetear el botón anterior
		if looking_at_button:
			looking_at_button.scale = Vector3.ONE
			# Restaurar material original
			if looking_at_button.has_node("MeshInstance3D"):
				var mesh = looking_at_button.get_node("MeshInstance3D")
				if looking_at_button == start_button:
					mesh.set_surface_override_material(0, start_button_material)
				elif looking_at_button == exit_button:
					mesh.set_surface_override_material(0, exit_button_material)
		
		# Actualizar al nuevo botón
		looking_at_button = current_button
		
		if looking_at_button:
			print(">>> Mirando: ", looking_at_button.name, " <<<")
	
	# Efecto visual en el botón que estamos mirando
	if looking_at_button:
		# Hacer el botón un poco más grande
		looking_at_button.scale = Vector3.ONE * 1.2
		
		# Cambiar material del botón para hacerlo brillar más
		if looking_at_button.has_node("MeshInstance3D"):
			var mesh = looking_at_button.get_node("MeshInstance3D")
			var highlight_material = StandardMaterial3D.new()
			if looking_at_button == start_button:
				highlight_material.albedo_color = Color(0.4, 1.0, 0.5, 1)
				highlight_material.emission_enabled = true
				highlight_material.emission = Color(0.3, 0.8, 0.3, 1)
				highlight_material.emission_energy = 2.0
			elif looking_at_button == exit_button:
				highlight_material.albedo_color = Color(1.0, 0.4, 0.4, 1)
				highlight_material.emission_enabled = true
				highlight_material.emission = Color(0.8, 0.3, 0.3, 1)
				highlight_material.emission_energy = 2.0
			mesh.set_surface_override_material(0, highlight_material)
		
		# Cambiar color del reticle a verde
		if reticle and reticle_material:
			reticle_material.albedo_color = Color(0, 1, 0, 1)
	else:
		# Reticle normal (blanco)
		if reticle and reticle_material:
			reticle_material.albedo_color = Color(1, 1, 1, 0.8)

func activate_button(button):
	print("Activando botón: ", button.name)
	
	if button == start_button:
		print("Iniciando juego...")
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	elif button == exit_button:
		print("Saliendo del juego...")
		get_tree().quit()

func _input(event):
	# Control de mouse para el editor
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Capturar mouse
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			is_mouse_captured = true
			print("Mouse capturado - Mueve el mouse para mirar alrededor")
			
			# También activar botón si estamos mirando uno
			if looking_at_button:
				print("Click detectado")
				activate_button(looking_at_button)
	
	# Movimiento de cámara con mouse capturado
	if event is InputEventMouseMotion and is_mouse_captured:
		camera_rotation.x += event.relative.x * mouse_sensitivity
		camera_rotation.y += event.relative.y * mouse_sensitivity
		camera_rotation.y = clamp(camera_rotation.y, -PI/2, PI/2)
	
	# Liberar mouse con ESC
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		is_mouse_captured = false
		print("Mouse liberado")
	
	# Activar el botón que estamos mirando al tocar la pantalla
	if event is InputEventScreenTouch and event.pressed:
		print("Touch detectado")
		if looking_at_button:
			print("Activando botón con touch: ", looking_at_button.name)
			activate_button(looking_at_button)
		else:
			print("No estás mirando ningún botón")
