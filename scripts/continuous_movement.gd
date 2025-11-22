extends Node3D

# Referencias
@onready var character_body = $Player
@onready var xr_origin = $Player/XROrigin3D
@onready var xr_camera = $Player/XROrigin3D/XRCamera3D
@onready var finish_zone = $FinishZone
@onready var end_game_menu = $EndGameMenu
@onready var reticle = $Player/XROrigin3D/XRCamera3D/Reticle

# Configuración de movimiento
@export var move_speed: float = 3.75  # Velocidad de movimiento (25% más rápido que 3.0)
@export var gravity: float = 20.0  # Gravedad (aumentada para caer más rápido)
@export var jump_force: float = 5.0  # Fuerza de salto automático
@export var max_step_height: float = 1.0  # Altura máxima de escalón que puede subir automáticamente

# Estado del movimiento
var is_moving: bool = false
var xr_interface: XRInterface
var velocity: Vector3 = Vector3.ZERO
var was_on_floor: bool = false
var game_finished: bool = false
var initial_position: Vector3
var looking_at_end_button: Node3D = null
var reticle_material: StandardMaterial3D
var end_menu_delay: float = 0.0  # Retraso antes de poder interactuar con el menú
var end_menu_ready: bool = false  # Si el menú está listo para interacción

# Variables para control con mouse (modo editor)
var mouse_sensitivity: float = 0.003
var camera_rotation: Vector2 = Vector2.ZERO
var is_mouse_captured: bool = false

func _ready():
	# Esperar un frame para que todo esté inicializado
	await get_tree().process_frame
	
	# Guardar posición inicial
	initial_position = character_body.global_position
	
	# Configurar el CharacterBody3D
	character_body.floor_stop_on_slope = true
	character_body.floor_max_angle = deg_to_rad(45)
	character_body.wall_min_slide_angle = deg_to_rad(15)
	
	# Conectar señales de la zona de meta y menú
	if finish_zone:
		finish_zone.player_reached_finish.connect(_on_player_finish)
	
	if end_game_menu:
		end_game_menu.restart_game.connect(_on_restart_game)
		end_game_menu.return_to_menu.connect(_on_return_to_menu)
	
	# Crear material del reticle
	if reticle:
		reticle_material = StandardMaterial3D.new()
		reticle_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		reticle_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		reticle_material.albedo_color = Color(1, 1, 1, 0.6)
		reticle.set_surface_override_material(0, reticle_material)
	
	# Inicializar la interfaz XR
	initialize_xr()
	
	print("Sistema VR con movimiento continuo listo")
	print("Posición inicial: ", character_body.global_position)
	print("Instrucciones:")
	print("  - Mira hacia donde quieres ir")
	print("  - Mantén presionado la pantalla para moverte")
	print("  - Suelta para detenerte")
	print("*** EN EDITOR: Click izquierdo captura mouse, ESC libera, Click derecho para moverse ***")

func initialize_xr():
	print("=== Inicializando VR ===")
	
	# NO inicializar XR si estamos en el editor (para poder usar mouse)
	if OS.has_feature("editor"):
		print("⚠ Modo EDITOR detectado - VR deshabilitado, usando controles de mouse")
		xr_interface = null
		return
	
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
		
	else:
		print("✗ No se encontró ninguna interfaz XR disponible")
		print("⚠ Usando modo editor con controles de mouse")

func _process(delta):
	# Control de cámara con mouse en editor (siempre permitir rotación)
	if not xr_interface or not xr_interface.is_initialized():
		# Aplicar rotación de mouse a la cámara
		xr_camera.rotation.y = -camera_rotation.x
		xr_camera.rotation.x = -camera_rotation.y
		xr_camera.rotation.x = clamp(xr_camera.rotation.x, -PI/2, PI/2)
	
	# Si el juego terminó, no procesar movimiento pero sí la cámara
	if game_finished:
		velocity = Vector3.ZERO
		character_body.velocity = velocity
		
		# Contar tiempo para el retraso del menú
		if not end_menu_ready:
			end_menu_delay += delta
			if end_menu_delay >= 1.5:  # 1.5 segundos de retraso
				end_menu_ready = true
				print("*** MENÚ LISTO - Ahora puedes seleccionar una opción ***")
		
		# Solo detectar botones después del retraso
		if end_menu_ready:
			check_end_menu_buttons()
		return
	
	# Aplicar gravedad si no está en el suelo
	if not character_body.is_on_floor():
		velocity.y -= gravity * delta
		if velocity.y < -50:  # Limitar velocidad de caída
			velocity.y = -50
	else:
		velocity.y = -0.1  # Pequeña fuerza hacia abajo para mantener contacto con el suelo
		was_on_floor = true
	
	# Si está presionado el botón, moverse
	if is_moving:
		move_forward(delta)
		
		# Detectar si chocó con una pared/escalón y saltar automáticamente
		if character_body.is_on_wall() and character_body.is_on_floor():
			try_auto_step_up()
	else:
		# Desacelerar horizontalmente cuando no se mueve
		velocity.x = lerp(velocity.x, 0.0, 10.0 * delta)
		velocity.z = lerp(velocity.z, 0.0, 10.0 * delta)
	
	# Aplicar movimiento con colisiones
	character_body.velocity = velocity
	character_body.move_and_slide()
	
	# Debug cada segundo
	if Engine.get_frames_drawn() % 60 == 0:
		print("Posición Y: ", character_body.global_position.y, " | En suelo: ", character_body.is_on_floor(), " | En pared: ", character_body.is_on_wall())

func move_forward(_delta):
	# Obtener la dirección hacia donde mira la cámara
	var forward_direction = -xr_camera.global_transform.basis.z
	
	# Mantener el movimiento en el plano horizontal (ignorar inclinación vertical)
	forward_direction.y = 0
	forward_direction = forward_direction.normalized()
	
	# Aplicar velocidad en la dirección del movimiento
	velocity.x = forward_direction.x * move_speed
	velocity.z = forward_direction.z * move_speed

func try_auto_step_up():
	# Intentar saltar automáticamente cuando se encuentra un escalón pequeño
	var space_state = get_world_3d().direct_space_state
	var player_pos = character_body.global_position
	var move_direction = Vector3(velocity.x, 0, velocity.z).normalized()
	
	# Raycast para detectar la altura del obstáculo frente al jugador
	var ray_start = player_pos + Vector3(0, 0.1, 0)  # Desde los pies
	var ray_end = ray_start + move_direction * 0.5  # 0.5m adelante
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	var result = space_state.intersect_ray(query)
	
	if result:
		# Hay algo adelante, verificar altura
		var obstacle_height = result.position.y - (player_pos.y - 0.85)  # Altura relativa al pie
		
		if obstacle_height > 0.05 and obstacle_height <= max_step_height:
			# Es un escalón que podemos subir
			print("Saltando escalón de altura: ", obstacle_height)
			velocity.y = jump_force
			return
	
	# Si no detectó con raycast, verificar hacia arriba
	ray_start = player_pos + Vector3(0, max_step_height + 0.1, 0)
	ray_end = ray_start + move_direction * 0.5
	
	query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	result = space_state.intersect_ray(query)
	
	if not result:
		# No hay obstáculo a la altura máxima del escalón, es escalable
		velocity.y = jump_force
		print("Salto automático activado")

func _input(event):
	# Control de mouse para el editor
	if event is InputEventMouseButton:
		# Click izquierdo: capturar mouse
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			is_mouse_captured = true
			print("Mouse capturado - Mueve el mouse para mirar alrededor")
		
		# Click derecho: moverse
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				is_moving = true
				print("Movimiento ACTIVADO (click derecho)")
			else:
				is_moving = false
				print("Movimiento DETENIDO")
	
	# Movimiento de cámara con mouse capturado
	if event is InputEventMouseMotion and is_mouse_captured:
		camera_rotation.x += event.relative.x * mouse_sensitivity
		camera_rotation.y += event.relative.y * mouse_sensitivity
		camera_rotation.y = clamp(camera_rotation.y, -PI/2, PI/2)
	
	# Liberar mouse con ESC
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		is_mouse_captured = false
		is_moving = false
		print("Mouse liberado")
	
	# Detectar cuando se presiona o suelta la pantalla (VR móvil)
	if event is InputEventScreenTouch:
		if not game_finished:
			if event.pressed:
				is_moving = true
				print("Movimiento ACTIVADO")
			else:
				is_moving = false
				print("Movimiento DETENIDO")
		else:
			# Si el juego terminó, el touch activa botones del menú final
			check_end_menu_button_press()

func _on_player_finish():
	print("¡¡¡JUEGO COMPLETADO!!!")
	game_finished = true
	is_moving = false
	velocity = Vector3.ZERO
	end_menu_delay = 0.0
	end_menu_ready = false
	
	# Posicionar el menú MÁS LEJOS frente al jugador
	if end_game_menu and xr_camera:
		var camera_forward = -xr_camera.global_transform.basis.z
		camera_forward.y = 0
		camera_forward = camera_forward.normalized()
		
		# Posición 5 metros frente al jugador (antes era 3), un poco más arriba
		var menu_position = xr_camera.global_position + camera_forward * 5.0
		menu_position.y = xr_camera.global_position.y + 0.5  # Medio metro más arriba
		end_game_menu.global_position = menu_position
		
		# Rotar el menú para que mire al jugador
		end_game_menu.look_at(xr_camera.global_position, Vector3.UP)
		end_game_menu.rotate_y(PI)  # Voltear 180° para que el texto se vea de frente
	
	# Mostrar menú de fin de juego
	if end_game_menu:
		end_game_menu.show_victory()
	
	print("Espera 1.5 segundos antes de poder seleccionar...")

func _on_restart_game():
	print("Reiniciando desde el inicio...")
	game_finished = false
	end_menu_ready = false
	end_menu_delay = 0.0
	character_body.global_position = initial_position
	velocity = Vector3.ZERO
	
	if end_game_menu:
		end_game_menu.visible = false
	
	# Reiniciar todos los sistemas de tráfico
	reset_all_traffic_systems()

func reset_all_traffic_systems():
	"""Reinicia todos los sistemas de tráfico en la escena"""
	var traffic_systems = [
		get_node_or_null("TrafficSystem/CrossingManager"),
		get_node_or_null("TrafficSystem2/CrossingManager"),
		get_node_or_null("TrafficSystem3/CrossingManager")
	]
	
	for traffic_system in traffic_systems:
		if traffic_system and traffic_system.has_method("reset_traffic_system"):
			traffic_system.reset_traffic_system()
	
	print("🔄 Todos los sistemas de tráfico reiniciados")

func _on_return_to_menu():
	print("Cargando menú principal...")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func check_end_menu_button_press():
	# Solo permitir activar botones después del retraso
	if not end_menu_ready:
		print("⏱ Espera un momento antes de seleccionar...")
		return
	
	# Activar el botón que estamos mirando
	if looking_at_end_button:
		if looking_at_end_button.name == "RestartButton":
			print("Activando: REINICIAR")
			_on_restart_game()
		elif looking_at_end_button.name == "MenuButton":
			print("Activando: MENU PRINCIPAL")
			_on_return_to_menu()

func check_end_menu_buttons():
	# Raycast para detectar qué botón del menú final estamos mirando
	var space_state = get_world_3d().direct_space_state
	var camera_transform = xr_camera.global_transform
	
	var from = camera_transform.origin
	var to = from - camera_transform.basis.z * 100.0
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false  # NO detectar áreas (FinishZone)
	query.collide_with_bodies = true  # SÍ detectar cuerpos (botones)
	query.exclude = [character_body]  # Excluir al jugador del raycast
	
	var result = space_state.intersect_ray(query)
	
	var current_button = null
	if result and result.collider:
		print("Raycast detectó: ", result.collider.name, " (", result.collider.get_class(), ")")
		if result.collider is StaticBody3D:
			current_button = result.collider
			print("✓ Es un StaticBody3D botón")

	
	# Actualizar qué botón estamos mirando
	if current_button != looking_at_end_button:
		# Resetear el botón anterior
		if looking_at_end_button:
			looking_at_end_button.scale = Vector3.ONE
			print("Resetear botón: ", looking_at_end_button.name)
		
		# Actualizar al nuevo botón
		looking_at_end_button = current_button
		
		if looking_at_end_button:
			print(">>> Ahora mirando: ", looking_at_end_button.name, " <<<")
	
	# Efecto visual en el botón que estamos mirando (solo si el menú está listo)
	if looking_at_end_button and end_menu_ready:
		# Hacer el botón más grande
		looking_at_end_button.scale = Vector3.ONE * 1.2
		# Cambiar color del reticle a verde
		if reticle and reticle_material:
			reticle_material.albedo_color = Color(0, 1, 0, 1)
	else:
		# Reticle normal (blanco o amarillo si está esperando)
		if reticle and reticle_material:
			if not end_menu_ready:
				reticle_material.albedo_color = Color(1, 1, 0, 0.8)  # Amarillo durante espera
			else:
				reticle_material.albedo_color = Color(1, 1, 1, 0.6)  # Blanco normal
