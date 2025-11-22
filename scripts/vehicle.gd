extends CharacterBody3D

## Vehículo que se mueve automáticamente por la carretera
## Parte del sistema de educación vial

@export var speed: float = 5.0  # Velocidad del vehículo (m/s)
@export var start_position: Vector3  # Posición inicial
@export var end_position: Vector3  # Posición final
@export var auto_restart: bool = false  # Reiniciar automáticamente (ahora false por defecto)
@export var auto_start: bool = false  # Iniciar automáticamente al cargar (ahora false) al llegar al final

var is_moving: bool = false
var direction: Vector3
var hit_area: Area3D
var traveled_distance: float = 0.0  # Distancia recorrida
var total_distance: float = 0.0  # Distancia total del recorrido

signal vehicle_started  # Se emite cuando el vehículo comienza a moverse
signal vehicle_finished  # Se emite cuando el vehículo llega al final

func _ready():
	# Desactivar colisiones del CharacterBody3D con el mundo (solo detectar con Area3D)
	collision_layer = 0  # No estar en ninguna capa
	collision_mask = 0  # No colisionar con nada
	
	# Obtener el Area3D hijo para detectar colisiones
	hit_area = get_node_or_null("Area3D")
	if hit_area:
		hit_area.body_entered.connect(_on_body_entered)
	
	# Guardar posición inicial desde el transform 3D si no está configurada
	if start_position == Vector3.ZERO:
		start_position = global_position
		print("🚗 Posición inicial tomada del transform 3D: ", start_position)
	
	# Calcular dirección de movimiento
	if end_position != Vector3.ZERO:
		direction = (end_position - start_position).normalized()
		total_distance = start_position.distance_to(end_position)
		# Rotar el vehículo hacia la dirección de movimiento
		look_at(global_position + direction, Vector3.UP)
	
	# Iniciar movimiento automáticamente solo si auto_start está activo
	if auto_start:
		start_movement()

func _physics_process(delta):
	if not is_moving:
		return
	
	# Mover el vehículo (sin colisiones con el mundo)
	velocity = direction * speed
	global_position += velocity * delta
	traveled_distance += velocity.length() * delta
	
	# Verificar si llegó al final (usando distancia O distancia recorrida)
	var distance_to_end = global_position.distance_to(end_position)
	if distance_to_end < 2.0 or traveled_distance >= total_distance:  # Margen de 2 metros o distancia completa
		finish_movement()

func start_movement():
	"""Inicia el movimiento del vehículo"""
	is_moving = true
	traveled_distance = 0.0
	global_position = start_position
	vehicle_started.emit()
	print("🚗 Vehículo iniciado en posición: ", start_position, " → distancia total: ", total_distance, "m")

func finish_movement():
	"""Detiene el vehículo al llegar al final"""
	is_moving = false
	vehicle_finished.emit()
	print("🚗 Vehículo llegó al final en posición: ", global_position)
	
	# Reiniciar después de un tiempo si está configurado
	if auto_restart:
		await get_tree().create_timer(3.0).timeout
		start_movement()

func stop():
	"""Detiene el vehículo"""
	is_moving = false

func _on_body_entered(body):
	"""Detecta colisión con el jugador"""
	if body.name == "Player":
		print("⚠️ ATROPELLO DETECTADO!")
		# Emitir señal para que el gestor maneje el atropello
		get_parent().get_node_or_null("CrossingManager")._on_player_hit()
