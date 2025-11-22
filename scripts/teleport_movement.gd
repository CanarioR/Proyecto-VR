extends Node3D

# Referencias
@onready var xr_camera = $XROrigin3D/XRCamera3D
@onready var xr_origin = $XROrigin3D
@onready var teleport_indicator = $TeleportIndicator

# Configuración
@export var max_teleport_distance: float = 10.0
@export var teleport_height_offset: float = 0.1
@export var raycast_length: float = 100.0

var is_valid_teleport_target: bool = false
var teleport_target_position: Vector3 = Vector3.ZERO
var xr_interface: XRInterface

func _ready():
	# Esperar un frame para que todo esté inicializado
	await get_tree().process_frame
	
	# Inicializar la interfaz XR
	initialize_xr()
	
	# Esperar otro frame
	await get_tree().process_frame
	
	# Configurar el indicador de teleporte
	if teleport_indicator:
		teleport_indicator.visible = false
	
	print("Sistema VR listo")

func initialize_xr():
	print("=== Inicializando VR ===")
	
	# Listar todas las interfaces disponibles
	print("Interfaces XR disponibles:")
	for i in range(XRServer.get_interface_count()):
		var interface = XRServer.get_interface(i)
		print("  [", i, "] ", interface.get_name())
	
	# Intentar con "Native mobile" primero
	xr_interface = XRServer.find_interface("Native mobile")
	
	if not xr_interface:
		print("No se encontró 'Native mobile', intentando con la interfaz 0")
		if XRServer.get_interface_count() > 0:
			xr_interface = XRServer.get_interface(0)
	
	if xr_interface:
		print("Usando interfaz: ", xr_interface.get_name())
		
		# Inicializar si no está inicializada
		if not xr_interface.is_initialized():
			print("Inicializando interfaz XR...")
			if xr_interface.initialize():
				print("✓ XR Interface inicializada exitosamente")
			else:
				print("✗ Error al inicializar XR Interface")
				return
		else:
			print("✓ XR Interface ya estaba inicializada")
		
		# Configurar el viewport para VR
		var viewport = get_viewport()
		viewport.use_xr = true
		print("✓ Viewport configurado para XR")
		
		# Verificar el estado final
		print("Estado final:")
		print("  - XR habilitado: ", viewport.use_xr)
		print("  - Interface inicializada: ", xr_interface.is_initialized())
		
	else:
		print("✗ No se encontró ninguna interfaz XR disponible")
		print("El modo VR no estará disponible")

func _process(delta):
	# Realizar raycast desde la cámara
	perform_gaze_raycast()
	
	# Actualizar indicador visual
	update_teleport_indicator()

func perform_gaze_raycast():
	var space_state = get_world_3d().direct_space_state
	var camera_transform = xr_camera.global_transform
	
	# Punto de inicio y dirección del ray
	var from = camera_transform.origin
	var to = from - camera_transform.basis.z * raycast_length
	
	# Crear query de raycast
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var result = space_state.intersect_ray(query)
	
	if result:
		var hit_point = result.position
		var distance = from.distance_to(hit_point)
		
		# Verificar si está dentro del rango
		if distance <= max_teleport_distance:
			is_valid_teleport_target = true
			teleport_target_position = hit_point
			teleport_target_position.y += teleport_height_offset
		else:
			is_valid_teleport_target = false
	else:
		is_valid_teleport_target = false

func update_teleport_indicator():
	if not teleport_indicator:
		return
	
	if is_valid_teleport_target:
		teleport_indicator.visible = true
		teleport_indicator.global_position = teleport_target_position
	else:
		teleport_indicator.visible = false

func _input(event):
	# Detectar el click/tap en la pantalla (botón de Cardboard y toques)
	if event is InputEventScreenTouch:
		if event.pressed:
			print("Touch detectado en posición: ", event.position)
			attempt_teleport()
	
	# Detectar cualquier botón del mouse (para pruebas en PC)
	if event is InputEventMouseButton:
		if event.pressed:
			print("Click del mouse detectado")
			attempt_teleport()
	
	# Detectar teclas para pruebas (espacio o enter)
	if event is InputEventKey:
		if event.pressed and (event.keycode == KEY_SPACE or event.keycode == KEY_ENTER):
			print("Tecla detectada")
			attempt_teleport()

func attempt_teleport():
	if is_valid_teleport_target:
		# Calcular la diferencia en XZ (mantener la altura actual del jugador)
		var current_pos = xr_origin.global_position
		var target_pos = teleport_target_position
		
		# Mantener la altura Y del origen actual
		target_pos.y = current_pos.y
		
		# Teleportar
		xr_origin.global_position = target_pos
		
		# Efecto opcional: puedes agregar sonido o animación aquí
		print("Teleportado a: ", target_pos)
