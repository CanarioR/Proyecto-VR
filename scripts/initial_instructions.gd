extends Node3D

## Sistema de instrucciones iniciales que se muestran al comenzar el nivel

@onready var instruction_label: Label3D = $InstructionLabel
@onready var objective_label: Label3D = $ObjectiveLabel

var display_time: float = 5.0  # Tiempo que se muestran las instrucciones
var fade_time: float = 1.0  # Tiempo de fade out
var elapsed_time: float = 0.0
var is_fading: bool = false
var camera: Camera3D

func _ready():
	# Buscar la cámara del jugador
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	if player:
		camera = player.get_node_or_null("XROrigin3D/XRCamera3D")
	
	# Configurar las instrucciones
	if instruction_label:
		instruction_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		instruction_label.pixel_size = 0.004
		instruction_label.modulate = Color.WHITE
		instruction_label.outline_size = 8
		instruction_label.outline_modulate = Color.BLACK
		instruction_label.visible = true
	
	if objective_label:
		objective_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		objective_label.pixel_size = 0.004
		objective_label.modulate = Color(1.0, 0.9, 0.2, 1.0)  # Amarillo dorado
		objective_label.outline_size = 6
		objective_label.outline_modulate = Color.BLACK
		objective_label.visible = true
	
	print("📋 Instrucciones iniciales mostradas")

func _process(delta):
	# Actualizar tiempo
	elapsed_time += delta
	
	# Posicionar las instrucciones frente a la cámara
	if camera and (instruction_label.visible or objective_label.visible):
		update_positions()
	
	# Iniciar fade out después del tiempo de visualización
	if elapsed_time >= display_time and not is_fading:
		is_fading = true
		print("📋 Ocultando instrucciones...")
	
	# Aplicar fade out
	if is_fading:
		var fade_progress = (elapsed_time - display_time) / fade_time
		var alpha = 1.0 - clamp(fade_progress, 0.0, 1.0)
		
		if instruction_label:
			instruction_label.modulate.a = alpha
		if objective_label:
			objective_label.modulate.a = alpha
		
		# Ocultar completamente cuando termine el fade
		if fade_progress >= 1.0:
			if instruction_label:
				instruction_label.visible = false
			if objective_label:
				objective_label.visible = false
			print("📋 Instrucciones ocultadas")
			set_process(false)  # Dejar de procesar

func update_positions():
	"""Actualiza la posición de las instrucciones frente a la cámara"""
	if not camera:
		return
	
	# Instrucción de control (arriba)
	if instruction_label and instruction_label.visible:
		var offset = Vector3(0, 0.8, -2.5)  # 2.5m frente a la cámara, 0.8m arriba
		var target_pos = camera.global_position + camera.global_transform.basis.z * -2.5
		target_pos.y += 0.8
		instruction_label.global_position = target_pos
	
	# Objetivo del juego (abajo)
	if objective_label and objective_label.visible:
		var offset = Vector3(0, 0.2, -2.5)  # 2.5m frente a la cámara, 0.2m arriba
		var target_pos = camera.global_position + camera.global_transform.basis.z * -2.5
		target_pos.y += 0.2
		objective_label.global_position = target_pos

func hide_instructions():
	"""Oculta las instrucciones inmediatamente (llamado externamente si es necesario)"""
	if instruction_label:
		instruction_label.visible = false
	if objective_label:
		objective_label.visible = false
	set_process(false)
