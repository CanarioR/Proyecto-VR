extends Node3D

var xr_interface: XRInterface

func _ready():
	# Inicializar la interfaz XR
	xr_interface = XRServer.find_interface("Native mobile")
	
	if xr_interface and xr_interface.is_initialized():
		print("XR Interface encontrada y inicializada: ", xr_interface.get_name())
		
		# Configurar el viewport para VR
		get_viewport().use_xr = true
		
		# Configurar el tracking
		xr_interface.xr_play_area_mode = XRInterface.XR_PLAY_AREA_SITTING
		
	else:
		print("No se pudo inicializar la interfaz XR")
		print("Interfaces disponibles:")
		for i in range(XRServer.get_interface_count()):
			var interface = XRServer.get_interface(i)
			print(" - ", interface.get_name())
		
		# Intentar inicializar manualmente
		if xr_interface:
			if xr_interface.initialize():
				get_viewport().use_xr = true
				print("XR Interface inicializada manualmente")
			else:
				print("Error: No se pudo inicializar la interfaz XR")

func _process(_delta):
	# Aquí puedes añadir lógica de juego
	pass
