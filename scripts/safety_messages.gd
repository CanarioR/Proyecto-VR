extends Node3D

## Sistema de mensajes educativos de seguridad vial en VR
## Muestra mensajes Label3D que siguen al jugador

@onready var message_label: Label3D = $MessageLabel

# Mensajes educativos
const MESSAGES = {
	"stop": "ALTO\nEspera a que \npasen los coches",
	"look": "Mira a ambos lados\nantes de cruzar",
	"safe": "Puedes cruzar\nNo hay vehículos",
	"danger": "PELIGRO\n¡Hay un vehículo!",
	"hit": "¡TE ATROPELLARON!\nRecuerda: \nsiempre mira antes de cruzar"
}

var current_message: String = ""
var message_timer: float = 0.0
var camera: Camera3D

func _ready():
	if not message_label:
		push_error("MessageLabel no encontrado")
		return
	
	# Configurar el label
	message_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	message_label.pixel_size = 0.006
	message_label.modulate = Color.WHITE
	message_label.outline_size = 8
	message_label.outline_modulate = Color.BLACK
	message_label.visible = false
	
	# Buscar la cámara
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	if player:
		camera = player.get_node_or_null("XROrigin3D/XRCamera3D")
	
	print("💬 Sistema de mensajes educativos listo")

func _process(delta):
	# Actualizar temporizador del mensaje
	if message_timer > 0:
		message_timer -= delta
		if message_timer <= 0:
			hide_message()
	
	# Posicionar el mensaje frente a la cámara
	if message_label.visible and camera:
		var offset = Vector3(0, 0.5, -2.5)  # 2.5m frente a la cámara, 0.5m arriba
		var target_pos = camera.global_position + camera.global_transform.basis.z * -2.5
		target_pos.y += 0.5
		message_label.global_position = target_pos

func show_message(message_key: String, duration: float = 3.0):
	"""Muestra un mensaje educativo por un tiempo determinado"""
	if not MESSAGES.has(message_key):
		push_error("Mensaje no encontrado: " + message_key)
		return
	
	current_message = message_key
	message_label.text = MESSAGES[message_key]
	message_label.visible = true
	message_timer = duration
	
	# Color según el tipo de mensaje
	match message_key:
		"stop", "danger", "hit":
			message_label.modulate = Color.RED
		"look":
			message_label.modulate = Color.YELLOW
		"safe":
			message_label.modulate = Color.GREEN
		_:
			message_label.modulate = Color.WHITE
	
	print("💬 Mostrando mensaje: ", message_key)

func hide_message():
	"""Oculta el mensaje actual"""
	message_label.visible = false
	current_message = ""
	message_timer = 0.0

func is_showing_message() -> bool:
	"""Retorna true si hay un mensaje visible"""
	return message_label.visible

func get_current_message() -> String:
	"""Retorna el mensaje actual"""
	return current_message
