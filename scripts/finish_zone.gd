extends Area3D

# Señal que se emite cuando el jugador entra a la zona
signal player_reached_finish

func _ready():
	print("✓ Zona de meta configurada en: ", global_position)
	# Conectar la señal de detección de cuerpos
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:
		print("¡JUGADOR LLEGÓ A LA META!")
		player_reached_finish.emit()
