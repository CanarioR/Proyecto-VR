extends Area3D

## Zona de cruce peatonal que detecta cuando el jugador intenta cruzar
## Activa mensajes de seguridad vial

signal player_entered_crossing  # El jugador entró a la zona de cruce
signal player_exited_crossing  # El jugador salió de la zona de cruce

var player_in_zone: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	print("🚸 Zona de cruce peatonal lista")

func _on_body_entered(body):
	if body.name == "Player":
		player_in_zone = true
		player_entered_crossing.emit()
		print("🚸 Jugador entró a la zona de cruce")

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false
		player_exited_crossing.emit()
		print("🚸 Jugador salió de la zona de cruce")

func is_player_in_zone() -> bool:
	return player_in_zone
