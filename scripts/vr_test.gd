extends Node3D

# Script de prueba simple para verificar VR

func _ready():
	print("========================================")
	print("PRUEBA DE VR - GOOGLE CARDBOARD")
	print("========================================")
	
	# Esperar un momento
	await get_tree().create_timer(0.5).timeout
	
	# 1. Verificar interfaces XR disponibles
	print("\n1. INTERFACES XR DISPONIBLES:")
	var interface_count = XRServer.get_interface_count()
	print("   Total de interfaces: ", interface_count)
	
	for i in range(interface_count):
		var interface = XRServer.get_interface(i)
		print("   [", i, "] ", interface.get_name(), " - Inicializada: ", interface.is_initialized())
	
	# 2. Intentar inicializar VR
	print("\n2. INICIALIZANDO VR:")
	var xr_interface = null
	
	# Intentar "Native mobile"
	xr_interface = XRServer.find_interface("Native mobile")
	if xr_interface:
		print("   ✓ Encontrada interfaz 'Native mobile'")
	else:
		print("   ✗ No se encontró 'Native mobile'")
		# Intentar con la primera disponible
		if interface_count > 0:
			xr_interface = XRServer.get_interface(0)
			print("   → Usando interfaz 0: ", xr_interface.get_name())
	
	# 3. Inicializar la interfaz
	if xr_interface:
		if not xr_interface.is_initialized():
			print("   Inicializando...")
			var result = xr_interface.initialize()
			if result:
				print("   ✓ Inicialización exitosa")
			else:
				print("   ✗ Error al inicializar")
		else:
			print("   ✓ Ya estaba inicializada")
		
		# 4. Activar XR en el viewport
		print("\n3. CONFIGURANDO VIEWPORT:")
		var viewport = get_viewport()
		viewport.use_xr = true
		print("   use_xr = ", viewport.use_xr)
		
		# 5. Información del viewport
		print("\n4. INFORMACIÓN DEL VIEWPORT:")
		print("   Tamaño: ", viewport.get_visible_rect().size)
		print("   XR activo: ", viewport.use_xr)
		
	else:
		print("\n✗ NO HAY INTERFAZ XR DISPONIBLE")
		print("El modo VR NO funcionará")
	
	# 6. Información del dispositivo
	print("\n5. INFORMACIÓN DEL SISTEMA:")
	print("   OS: ", OS.get_name())
	print("   Modelo: ", OS.get_model_name())
	print("   Pantalla: ", DisplayServer.screen_get_size())
	
	print("\n========================================")
	print("FIN DE LA PRUEBA")
	print("========================================")

func _input(event):
	# Detectar cualquier input
	if event is InputEventScreenTouch:
		print("TOUCH: ", event.pressed, " en ", event.position)
	elif event is InputEventScreenDrag:
		print("DRAG: ", event.position)
	elif event is InputEventKey:
		print("KEY: ", event.keycode)
