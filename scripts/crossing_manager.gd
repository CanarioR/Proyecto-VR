extends Node

## Gestor de tráfico y educación vial
## Coordina vehículos, zonas de cruce y mensajes educativos

@export var crossing_zone_path: NodePath  # Zona de cruce peatonal
@export var safety_messages_path: NodePath  # Sistema de mensajes
@export var player_path: NodePath  # Referencia al jugador

var crossing_zone: Area3D
var safety_messages: Node3D
var player: CharacterBody3D
var vehicles: Array[CharacterBody3D] = []  # Lista de vehículos

var is_safe_to_cross: bool = false
var player_in_crossing: bool = false
var has_been_hit: bool = false
var respawn_position: Vector3
var vehicles_started: bool = false  # Para controlar si ya iniciaron los vehículos

func _ready():
	# Obtener referencias a los nodos
	if crossing_zone_path:
		crossing_zone = get_node(crossing_zone_path)
	if safety_messages_path:
		safety_messages = get_node(safety_messages_path)
	if player_path:
		player = get_node(player_path)
	
	# Obtener solo los vehículos hijos del mismo padre (TrafficSystem)
	await get_tree().process_frame
	var parent_node = get_parent()
	for child in parent_node.get_children():
		if child is CharacterBody3D and child.is_in_group("vehicle"):
			vehicles.append(child)
			print("🚗 Vehículo agregado al sistema: ", child.name)
	
	# Guardar posición de respawn
	if player:
		respawn_position = player.global_position
	
	# Conectar señales de la zona de cruce
	if crossing_zone:
		if crossing_zone.has_signal("player_entered_crossing"):
			crossing_zone.player_entered_crossing.connect(_on_player_entered_crossing)
		if crossing_zone.has_signal("player_exited_crossing"):
			crossing_zone.player_exited_crossing.connect(_on_player_exited_crossing)
	
	# Conectar señales de los vehículos
	for vehicle in vehicles:
		if vehicle.has_signal("vehicle_started"):
			vehicle.vehicle_started.connect(_on_vehicle_started)
		if vehicle.has_signal("vehicle_finished"):
			vehicle.vehicle_finished.connect(_on_vehicle_finished)
	
	# Iniciar verificación de seguridad
	update_safety_status()
	print("🚦 Gestor de tráfico listo con ", vehicles.size(), " vehículos")

func _process(_delta):
	update_safety_status()
	
	# Mostrar mensajes según el estado
	if player_in_crossing and not has_been_hit:
		if not is_safe_to_cross:
			# Hay vehículos cerca
			if safety_messages and not safety_messages.is_showing_message():
				safety_messages.show_message("stop", 2.0)
		else:
			# Es seguro cruzar
			if safety_messages and not safety_messages.is_showing_message():
				safety_messages.show_message("safe", 1.5)

func update_safety_status():
	"""Actualiza si es seguro cruzar la calle"""
	is_safe_to_cross = true
	
	# Verificar si hay vehículos en movimiento
	for vehicle in vehicles:
		if vehicle.is_moving:
			is_safe_to_cross = false
			break

func _on_player_entered_crossing():
	"""El jugador entró a la zona de cruce"""
	player_in_crossing = true
	has_been_hit = false
	
	# Iniciar vehículos solo la primera vez que el jugador entra
	if not vehicles_started:
		vehicles_started = true
		for vehicle in vehicles:
			vehicle.start_movement()
		print("🚦 Vehículos iniciados - el jugador entró a la zona de cruce")
	
	# Mostrar mensaje de precaución
	if safety_messages:
		safety_messages.show_message("look", 3.0)
	
	print("🚦 Jugador en zona de cruce. Seguro: ", is_safe_to_cross)

func _on_player_exited_crossing():
	"""El jugador salió de la zona de cruce"""
	player_in_crossing = false
	
	# Ocultar mensajes
	if safety_messages:
		safety_messages.hide_message()
	
	print("🚦 Jugador salió de la zona de cruce")

func _on_vehicle_started():
	"""Un vehículo comenzó a moverse"""
	update_safety_status()
	
	# Si el jugador está en la zona, advertir
	if player_in_crossing and safety_messages:
		safety_messages.show_message("danger", 2.0)

func _on_vehicle_finished():
	"""Un vehículo terminó de moverse"""
	update_safety_status()
	
	# Si el jugador está esperando, indicar que puede cruzar
	if player_in_crossing and is_safe_to_cross and safety_messages:
		safety_messages.show_message("safe", 2.0)

func _on_player_hit():
	"""El jugador fue atropellado"""
	if has_been_hit:
		return  # Evitar múltiples atropellos
	
	has_been_hit = true
	print("💥 ¡JUGADOR ATROPELLADO!")
	
	# Mostrar mensaje educativo
	if safety_messages:
		safety_messages.show_message("hit", 5.0)
	
	# Detener al jugador momentáneamente
	if player:
		player.velocity = Vector3.ZERO
	
	# Esperar y reiniciar posición
	await get_tree().create_timer(3.0).timeout
	respawn_player()

func respawn_player():
	"""Reinicia al jugador en la posición de respawn"""
	if player:
		player.global_position = respawn_position
		player.velocity = Vector3.ZERO
		print("🔄 Jugador reiniciado en posición segura")
	
	has_been_hit = false
	
	# Reiniciar TODOS los sistemas de tráfico después del atropello
	var main_scene = get_node("/root/Main")
	if main_scene and main_scene.has_method("reset_all_traffic_systems"):
		main_scene.reset_all_traffic_systems()
	
	# Ocultar mensaje después de un momento
	if safety_messages:
		await get_tree().create_timer(2.0).timeout
		safety_messages.hide_message()

func get_is_safe_to_cross() -> bool:
	"""Retorna si es seguro cruzar"""
	return is_safe_to_cross

func get_player_in_crossing() -> bool:
	"""Retorna si el jugador está en la zona de cruce"""
	return player_in_crossing

func reset_traffic_system():
	"""Reinicia todo el sistema de tráfico"""
	print("🔄 Reiniciando sistema de tráfico...")
	
	# Resetear estado
	vehicles_started = false
	player_in_crossing = false
	has_been_hit = false
	is_safe_to_cross = false
	
	# Detener y reiniciar todos los vehículos a su posición inicial
	for vehicle in vehicles:
		vehicle.stop()
		vehicle.global_position = vehicle.start_position
		vehicle.traveled_distance = 0.0
	
	# Ocultar mensajes
	if safety_messages:
		safety_messages.hide_message()
	
	print("🚦 Sistema de tráfico reiniciado")
