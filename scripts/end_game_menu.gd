extends Node3D

@onready var restart_button = $UI/RestartButton
@onready var menu_button = $UI/MenuButton

signal restart_game
signal return_to_menu

func _ready():
	visible = false
	print("Menú de fin de juego cargado")

func show_victory():
	visible = true
	print("=== ¡JUEGO COMPLETADO! ===")
	print("Opciones: Reiniciar o Volver al Menú")

func _on_restart_pressed():
	print("Reiniciando juego...")
	restart_game.emit()

func _on_menu_pressed():
	print("Volviendo al menú...")
	return_to_menu.emit()
