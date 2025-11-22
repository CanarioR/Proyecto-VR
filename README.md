# Aprendiendo a Cruzar la Calle 🎮



**Proyecto de Educación Vial en Realidad Virtual**



Experiencia educativa en VR diseñada para Google Cardboard que enseña seguridad peatonal mediante la simulación de cruces de calle con tráfico vehicular.Juego de realidad virtual educativo desarrollado en **Godot 4.5** para dispositivos Android con **Google Cardboard**. El jugador debe recorrer un escenario 3D con conciencia peatonal, aprendiendo a cruzar calles de forma segura.



---



## 📋 Descripción**Autor:** Diego Armando Sanchez RubioJuego de realidad virtual educativo desarrollado en **Godot 4.5** para dispositivos Android con **Google Cardboard**. El jugador debe recorrer un escenario 3D con conciencia peatonal, aprendiendo a cruzar calles de forma segura.



Juego educativo de realidad virtual que simula múltiples cruces de calle con tráfico vehicular. El jugador debe aprender a cruzar de forma segura, observando el tráfico y esperando el momento adecuado. El sistema proporciona retroalimentación educativa en tiempo real sobre la seguridad peatonal.



**Características principales:**---

- 🚗 **Sistema de tráfico escalonado**: 3 zonas de cruce independientes con 6 vehículos de diferentes colores

- 🎯 **Activación por proximidad**: Los vehículos solo se mueven cuando llegas a cada zona específica

- 📢 **Mensajes educativos**: Indicadores visuales de seguridad codificados por color

- 🔄 **Sistema de reinicio completo**: Resetea todas las zonas al reiniciar o después de un atropello## 📋 Descripción**Autor:** Diego Armando Sanchez RubioJuego de realidad virtual desarrollado en **Godot 4.5** para dispositivos Android con **Google Cardboard**. El jugador debe recorrer un escenario 3D hasta llegar a la meta.Este es un proyecto base para crear juegos VR para Android compatible con Google Cardboard.

- 🎮 **Control VR**: Movimiento continuo con Google Cardboard

- 🏆 **Objetivo claro**: Llegar al final sin ser atropellado



---Juego VR educativo donde el jugador:



## 🎮 Controles- 🚶 Navega por un escenario 3D importado desde Blender



- **Mantener pulsado el botón de Cardboard**: Avanzar- 📱 Se mueve continuamente hacia adelante mientras mantiene presionada la pantalla---

- **Mirar hacia el objetivo**: Orientar el movimiento

- **Soltar el botón**: Detenerse- 🪜 Salta automáticamente pequeños escalones (≤1m)



---- 🚗 **Aprende educación vial**: Debe cruzar calles respetando el tráfico vehicular



## 🚦 Mecánicas de Juego- 💬 Recibe mensajes educativos sobre seguridad peatonal en tiempo real



### Sistema de Tráfico Escalonado- 🚸 Experimenta las consecuencias de cruzar sin mirar (atropello educativo)## 📋 Descripción**Autor:** Diego Armando Sanchez Rubio## Estructura del Proyecto



El juego presenta **3 zonas de cruce** distribuidas a lo largo del escenario:- 🏁 Debe llegar a una zona de meta al final del nivel



1. **Primera Zona (Z=37)** - Vehículos rojo y azul (velocidad: 5 m/s)- 🔄 Puede reiniciar el juego o volver al menú principal al completarlo

2. **Segunda Zona (Z=60)** - Vehículos verde y amarillo (velocidad: 5.5 m/s)

3. **Tercera Zona (Z=80)** - Vehículos naranja y morado (velocidad: 6 m/s)- 🚧 Bordes invisibles que mantienen al jugador dentro del escenario



**Funcionamiento:**Juego VR educativo donde el jugador:

- Los vehículos de cada zona **solo inician** cuando el jugador entra en esa zona de cruce específica

- Los vehículos avanzan hasta el final de su trayecto y **se detienen**---

- No hay reinicio automático de vehículos (pase único por zona)

- Cada zona es independiente de las demás- Navega por un escenario 3D importado desde Blender



### Mensajes Educativos## 🎯 Características



El sistema muestra mensajes codificados por color según la situación:- Se mueve continuamente hacia adelante mientras mantiene presionada la pantalla---- **scenes/**: Contiene las escenas del juego



- 🔴 **DETENTE** (Rojo) - Hay vehículos en movimiento cerca### ✅ Sistema VR Completo

- 🟡 **MIRA A AMBOS LADOS** (Amarillo) - Entrando a la zona de cruce

- 🟢 **SEGURO CRUZAR** (Verde) - No hay vehículos en movimiento- Soporte para Google Cardboard- Salta automáticamente pequeños escalones (≤1m)

- 🟠 **¡PELIGRO!** (Naranja) - Vehículo aproximándose

- 🔴 **¡ATROPELLADO!** (Rojo brillante) - Colisión con vehículo- Seguimiento de cabeza con giroscopio



### Sistema de Reinicio- Modo editor con controles de mouse para pruebas- **Aprende educación vial**: Debe cruzar calles respetando el tráfico vehicular  - `main.tscn`: Escena principal con configuración VR



El juego se reinicia completamente en dos situaciones:- Reticle/cursor visual con feedback de color (blanco/amarillo/verde)



1. **Botón REINICIAR**: El jugador presiona el botón en el menú de fin de juego- Recibe mensajes educativos sobre seguridad peatonal

2. **Atropello**: El jugador es golpeado por un vehículo

### ✅ Menú Principal

**Al reiniciar:**

- Todos los 6 vehículos vuelven a su posición inicial- Título del proyecto "PROYECTO VR"- Debe llegar a una zona de meta al final del nivel## 📋 Descripción- **scripts/**: Contiene los scripts del juego

- Todas las zonas de cruce se resetean (vehicles_started = false)

- El jugador regresa a la posición de inicio- Nombre del autor (Diego Armando Sanchez Rubio)

- Los mensajes educativos se ocultan

- Botones interactivos con gaze + touch:- Puede reiniciar el juego o volver al menú principal al completarlo

---

  - **INICIAR JUEGO**: Comienza la experiencia

## 🏗️ Estructura del Proyecto

  - **SALIR**: Cierra la aplicación  - `vr_controller.gd`: Script principal que inicializa la interfaz XR

```

vr/- Feedback visual (botones crecen y brillan al mirarlos)

├── scenes/

│   ├── menu.tscn           # Menú principal VR---

│   └── main.tscn           # Escena principal del juego

├── scripts/### ✅ Sistema de Movimiento

│   ├── continuous_movement.gd      # Sistema de movimiento del jugador

│   ├── crossing_manager.gd        # Gestor de tráfico y educación vial- **Movimiento continuo**: Mantén presionada la pantalla para avanzarJuego VR simple donde el jugador:- **models/**: Aquí puedes colocar tus modelos de Blender

│   ├── crossing_zone.gd           # Zona de detección de cruce

│   ├── vehicle.gd                 # Comportamiento de vehículos- **Dirección**: Hacia donde mires con la cabeza

│   ├── safety_messages.gd         # Sistema de mensajes educativos

│   ├── initial_instructions.gd    # Instrucciones al inicio- **Velocidad**: 3.75 m/s (optimizada para VR)## 🎯 Características

│   ├── finish_zone.gd             # Zona de meta

│   ├── end_game_menu.gd           # Menú de fin de juego- **Salto automático**: Sube escalones hasta 1m de altura

│   ├── add_collisions.gd          # Generador de colisiones

│   └── menu_vr.gd                 # Lógica del menú VR- **Colisiones físicas**: No puedes atravesar árboles u objetos- Navega por un escenario 3D importado desde Blender

├── models/

│   └── EscenarioPrincipal.glb     # Modelo 3D del escenario- **Bordes invisibles**: El jugador no puede salirse del mapa

├── icon.svg                        # Icono del proyecto

├── project.godot                   # Configuración del proyecto### ✅ Sistema VR Completo

└── README.md                       # Este archivo

```### ✅ Sistema de Educación Vial (Safety Crossing) 🚗🚸



---- Soporte para Google Cardboard- Se mueve continuamente hacia adelante mientras mantiene presionada la pantalla## Configuración VR



## 🔧 Componentes TécnicosSistema completo de conciencia peatonal que enseña a cruzar calles de forma segura:



### TrafficSystem (Sistema de Tráfico)- Seguimiento de cabeza con giroscopio



Cada uno de los 3 sistemas de tráfico contiene:#### 🚗 Dos Vehículos Autónomos



- **CrossingManager**: Coordina vehículos, zonas y mensajes- **Vehículo Rojo**: Se mueve de izquierda a derecha (carril 1)- Modo editor con controles de mouse para pruebas- Salta automáticamente pequeños escalones (≤1m)

- **CrossingZone** (Area3D): Detecta entrada/salida del jugador

- **Vehicle** × 2: Dos vehículos que circulan por la zona- **Vehículo Azul**: Se mueve de izquierda a derecha (carril 2)

- **Referencia a SafetyMessages**: Sistema compartido de mensajes

- Velocidad realista: 5 m/s- Reticle/cursor visual con feedback de color

**Características de los vehículos:**

- Sin colisión con terreno (`collision_layer = 0`, `collision_mask = 0`)- **Inicio inteligente**: Solo se mueven cuando el jugador entra a la zona de cruce

- Movimiento directo mediante posición (`velocity * delta`)

- Verificación dual de llegada: distancia < 2m O traveled_distance >= total_distance- **Recorrido único**: No se reinician automáticamente (cruzan una sola vez)- Debe llegar a una zona de meta al final del nivelEl proyecto está configurado para:

- Posición inicial automática desde el editor 3D

- Detección de colisión con jugador mediante Area3D- **Sin colisiones con el terreno**: Atraviesan el escenario sin obstáculos



### CrossingManager- **Posición dinámica**: Se toma del editor 3D automáticamente### ✅ Menú Principal



**Responsabilidades:**

- Detectar solo los vehículos hijos de su TrafficSystem padre

- Iniciar vehículos cuando el jugador entra a la zona (primera vez únicamente)#### 🚸 Zona de Cruce Peatonal- Título del proyecto- Puede reiniciar el juego o volver al menú principal al completarlo- Renderizado móvil optimizado (gl_compatibility)

- Monitorear seguridad del cruce en tiempo real

- Mostrar mensajes educativos apropiados- Detecta automáticamente cuando el jugador intenta cruzar

- Gestionar atropellos y respawn del jugador

- Resetear estado del sistema cuando se solicita- Activa el sistema de tráfico al primer contacto- Nombre del autor



**Variables clave:**- Monitorea el estado del tráfico en tiempo real

- `vehicles_started: bool` - Controla si los vehículos ya iniciaron (evita reinicio automático)

- `is_safe_to_cross: bool` - Indica si no hay vehículos en movimiento- Dimensiones ajustables desde el editor- Botones interactivos con gaze + touch:- Soporte para XR nativo de Android

- `player_in_crossing: bool` - El jugador está en la zona de cruce

- `has_been_hit: bool` - Evita múltiples detecciones de atropello



### Vehicle (Vehículo)#### 💬 Mensajes Educativos en VR  - **INICIAR JUEGO**



**Sistema de movimiento:**Los mensajes aparecen flotantes frente al jugador con colores distintivos:

```gdscript

func _physics_process(delta):  - **SALIR**---- Google Cardboard (modo de juego sentado)

    if is_moving and not is_finished:

        # Movimiento directo sin física- 👀 **"Mira a ambos lados antes de cruzar"** (Amarillo)

        global_position += velocity * delta

        traveled_distance += velocity.length() * delta  - Se muestra al entrar a la zona de cruce- Feedback visual (botones crecen y brillan al mirarlos)

        

        # Verificación dual de llegada  - Enseña la primera regla de seguridad vial

        var distance_to_end = global_position.distance_to(end_position)

        if distance_to_end < 2.0 or traveled_distance >= total_distance:  - Duración: 3 segundos- Resolución 1920x1080

            arrive_at_destination()

```



**Características:**- ⛔ **"ALTO - Espera a que pasen los coches"** (Rojo)### ✅ Sistema de Movimiento

- `collision_layer = 0` y `collision_mask = 0`: Sin colisión con terreno

- `start_position`: Tomada automáticamente de `global_position` en `_ready()`  - Aparece cuando hay vehículos en movimiento

- Señales: `vehicle_started`, `vehicle_finished`

- Area3D hijo para detectar colisiones con jugador  - Previene cruces peligrosos- **Movimiento continuo**: Mantén presionada la pantalla para avanzar## 🎯 Características



### Sistema de Reinicio Global  - Se muestra continuamente mientras hay tráfico



**Función en continuous_movement.gd:**- **Dirección**: Hacia donde mires con la cabeza

```gdscript

func reset_all_traffic_systems():- ✅ **"Puedes cruzar - No hay vehículos"** (Verde)

    var traffic_systems = [

        get_node_or_null("TrafficSystem/CrossingManager"),  - Indica que es seguro cruzar- **Velocidad**: 3.75 m/s## Cómo usar tu modelo de Blender

        get_node_or_null("TrafficSystem2/CrossingManager"),

        get_node_or_null("TrafficSystem3/CrossingManager")  - Refuerza el comportamiento correcto

    ]

      - Duración: 1.5-2 segundos- **Salto automático**: Sube escalones hasta 1m de altura

    for traffic_system in traffic_systems:

        if traffic_system and traffic_system.has_method("reset_traffic_system"):

            traffic_system.reset_traffic_system()

```- ⚠️ **"PELIGRO - ¡Hay un vehículo!"** (Rojo)- **Colisiones**: No puedes atravesar árboles u objetos### ✅ Sistema VR Completo



**Se llama desde:**  - Advertencia de peligro inminente

- `_on_restart_game()` - Botón REINICIAR

- `respawn_player()` en CrossingManager - Después de atropello  - Alerta cuando un vehículo inicia su movimiento



### SafetyMessages (Mensajes de Seguridad)



Billboard Label3D que sigue la cámara del jugador, mostrando mensajes educativos:- ❌ **"¡TE ATROPELLARON! - Recuerda: siempre mira antes de cruzar"** (Rojo)### ✅ Sistema de Educación Vial (Safety Crossing) 🚗🚸- Soporte para Google Cardboard1. Exporta tu escenario desde Blender como `.glb` o `.gltf`



```gdscript  - Mensaje educativo tras colisión

MESSAGES = {

    "stop": {"text": "🔴 DETENTE - HAY TRÁFICO", "color": Color.RED},  - Refuerza el aprendizaje mediante consecuencias

    "look": {"text": "🟡 MIRA A AMBOS LADOS", "color": Color.YELLOW},

    "safe": {"text": "🟢 SEGURO CRUZAR", "color": Color.GREEN},  - Duración: 5 segundos

    "danger": {"text": "🟠 ¡PELIGRO! VEHÍCULO CERCA", "color": Color.ORANGE},

    "hit": {"text": "🔴 ¡ATROPELLADO! MIRA ANTES DE CRUZAR", "color": Color(1, 0.2, 0.2)}Sistema completo de conciencia peatonal que enseña a cruzar calles de forma segura:- Seguimiento de cabeza con giroscopio2. Copia el archivo a la carpeta `models/`

}

```#### 🔄 Sistema de Seguridad y Reinicio



### InvisibleBoundaries (Límites Invisibles)- **Detección de atropello**: Si el jugador cruza con vehículos en movimiento



4 muros StaticBody3D que evitan que el jugador salga del escenario:- **Respawn seguro**: Regresa al jugador a posición inicial tras atropello (3 segundos)

- Frontal, Trasero, Izquierdo, Derecho

- Cada uno con CollisionShape3D tipo Box- **Pausa educativa**: Muestra mensaje durante 5 segundos para reforzar el aprendizaje#### Vehículos Autónomos- Modo editor con controles de mouse para pruebas3. En Godot, arrastra el modelo a la escena `main.tscn`



---- **Reinicio automático del tráfico**: Los vehículos vuelven a su posición tras atropello



## 🎯 Flujo de Juego- **Reinicio completo**: Al presionar "REINICIAR" todo el sistema se resetea- Se mueven automáticamente por la carretera



1. **Inicio**: El jugador aparece en la posición inicial- **Gestor de tráfico**: Coordina vehículos, mensajes y seguridad del cruce

   - Se muestra: "Mantén pulsado para avanzar"

   - Objetivo: "Llegar hasta el otro lado sin ser atropellado"- Velocidad configurable (por defecto 5 m/s)- Reticle/cursor visual con feedback de color4. Ajusta la posición y escala según necesites

   - Las instrucciones desaparecen después de 5 segundos

### ✅ Sistema de Final de Juego

2. **Primera Zona de Cruce (Z=37)**:

   - El jugador avanza y entra en la primera zona- Zona de meta configurable (Z=104)- Reinicio automático después de completar su recorrido

   - Los vehículos rojo y azul comienzan a moverse

   - Aparece mensaje: "🟡 MIRA A AMBOS LADOS"- Pausa de 1.5 segundos al llegar (evita reinicio accidental)

   - El jugador debe esperar a que sea seguro cruzar

- Menú de victoria con opciones:- Detectan colisiones con el jugador

3. **Segunda Zona de Cruce (Z=60)**:

   - Al llegar a la segunda zona, se activan vehículos verde y amarillo  - **REINICIAR**: Vuelve al inicio del nivel con tráfico reseteado

   - Mayor velocidad (5.5 m/s) = mayor dificultad

   - Sistema de mensajes educativos sigue activo  - **MENU PRINCIPAL**: Regresa al menú de inicio



4. **Tercera Zona de Cruce (Z=80)**:- Indicador visual de estado (cursor amarillo → blanco → verde)

   - Última zona con vehículos naranja y morado

   - Máxima velocidad (6.0 m/s)#### Zona de Cruce Peatonal### ✅ Menú Principal## Para probar en el editor

   - Requiere observación cuidadosa

---

5. **Meta**: Al llegar a la zona final

   - Aparece menú con tiempo y opciones- Detecta automáticamente cuando el jugador intenta cruzar

   - "REINICIAR" o "MENÚ PRINCIPAL"

## 🗂️ Estructura del Proyecto

6. **Atropello**: Si un vehículo golpea al jugador

   - Mensaje: "🔴 ¡ATROPELLADO! MIRA ANTES DE CRUZAR"- Activa mensajes educativos de seguridad- Título del proyecto

   - Espera de 3 segundos

   - Reinicio completo del juego (todos los sistemas)```



---vr/- Monitora el estado del tráfico en tiempo real



## 🛠️ Requisitos Técnicos├── scenes/



- **Motor**: Godot 4.5+│   ├── menu.tscn              # Menú principal VR- Nombre del autor1. Abre el proyecto en Godot 4.5

- **Renderer**: Mobile (gl_compatibility)

- **XR**: Native Mobile Interface│   └── main.tscn              # Escena del juego

- **Dispositivo**: Google Cardboard o compatible

- **Plataforma**: Android├── scripts/#### Mensajes Educativos en VR



---│   ├── menu_vr.gd             # Lógica del menú (gaze + touch)



## 📱 Configuración VR│   ├── continuous_movement.gd # Movimiento, colisiones y fin de juegoLos mensajes aparecen flotantes frente al jugador con colores distintivos:- Botones interactivos con gaze + touch:2. Abre la escena `scenes/main.tscn`



El proyecto está configurado para:│   ├── finish_zone.gd         # Detector de zona de meta

- **Interfaz XR**: Native Mobile

- **Modo de renderizado**: Compatible con móviles│   ├── end_game_menu.gd       # Menú de victoria

- **Orientación**: Landscape

- **Permisos Android**: XR_MODE_OPENXR│   ├── add_collisions.gd      # Generador automático de colisiones



---│   ├── vehicle.gd             # Vehículo autónomo con detección de colisión- 👀 **"Mira a ambos lados antes de cruzar"** (Amarillo)  - **INICIAR JUEGO**3. Presiona F5 para ejecutar



## 👨‍💻 Autor│   ├── crossing_zone.gd       # Zona de cruce peatonal



**Diego Armando Sanchez Rubio**│   ├── safety_messages.gd     # Sistema de mensajes educativos en VR  - Se muestra al entrar a la zona de cruce



---│   └── crossing_manager.gd    # Gestor de tráfico y educación vial



## 🎓 Propósito Educativo├── models/  - Enseña la primera regla de seguridad vial  - **SALIR**



Este proyecto fue desarrollado como herramienta educativa para enseñar seguridad vial a través de realidad virtual. El sistema escalonado permite un aprendizaje progresivo:│   └── EscenarioPrincipal.glb # Escenario 3D de Blender



1. **Primera zona**: Introducción al sistema de tráfico├── project.godot              # Configuración del proyecto

2. **Segunda zona**: Aumento de dificultad (velocidad)

3. **Tercera zona**: Aplicación de conocimientos adquiridos└── README.md                  # Este archivo



Los mensajes educativos codificados por color refuerzan el aprendizaje visual y proporcionan retroalimentación inmediata sobre las decisiones del jugador.```- ⛔ **"ALTO - Espera a que pasen los coches"** (Rojo)- Feedback visual (botones crecen y brillan al mirarlos)**Nota**: El modo VR real solo funcionará en un dispositivo Android. En el editor verás una vista normal en 3D.



---



## 🔄 Historial de Versiones---  - Aparece cuando hay vehículos en movimiento



### v2.0 - Sistema Escalonado

- ✅ 3 zonas de cruce independientes con 6 vehículos

- ✅ Activación por proximidad (cada zona se activa al llegar)## 🎮 Controles  - Previene cruces peligrosos

- ✅ Sistema de reinicio global para todas las zonas

- ✅ Velocidades progresivas (5.0 → 5.5 → 6.0 m/s)

- ✅ 6 materiales de vehículos (rojo, azul, verde, amarillo, naranja, morado)

### En Dispositivo Móvil (VR):

### v1.0 - Sistema Básico

- ✅ Sistema de tráfico con 2 vehículos- **Girar cabeza**: Mirar alrededor

- ✅ Mensajes educativos de seguridad

- ✅ Movimiento continuo en VR- **Mantener touch en pantalla**: Moverse hacia adelante- ✅ **"Puedes cruzar - No hay vehículos"** (Verde)### ✅ Sistema de Movimiento## Para exportar a Android

- ✅ Detección de atropellos

- ✅ Sistema de respawn- **Mirar botón + touch**: Activar botón del menú

- ✅ Límites invisibles del escenario

- ✅ Instrucciones iniciales con fade out- **👀 Observar el tráfico**: Importante para cruzar calles de forma segura  - Indica que es seguro cruzar



---



## 🚀 Próximas Mejoras Sugeridas### En Editor de Godot (Pruebas):  - Refuerza el comportamiento correcto- **Movimiento continuo**: Mantén presionada la pantalla para avanzar



- [ ] Diferentes tipos de vehículos (autos, motos, buses)- **Click izquierdo**: Capturar mouse

- [ ] Semáforos funcionales

- [ ] Sistema de puntuación basado en seguridad- **Mover mouse**: Rotar cámara

- [ ] Diferentes escenarios (ciudad, zona escolar, etc.)

- [ ] Modo tutorial paso a paso- **Click derecho (mantener)**: Moverse

- [ ] Sonidos de tráfico y ambiente urbano

- [ ] Efectos visuales adicionales (sombras de vehículos, partículas)- **ESC**: Liberar cursor- ⚠️ **"PELIGRO - ¡Hay un vehículo!"** (Rojo)- **Dirección**: Hacia donde mires con la cabeza1. Ve a Proyecto → Exportar



---



## 📄 Licencia---  - Advertencia de peligro inminente



Proyecto educativo desarrollado para propósitos académicos.


## ⚙️ Configuración Técnica  - Alerta cuando un vehículo está cerca- **Velocidad**: 3.75 m/s2. Selecciona "Android"



### Motor y Plataforma

- **Godot**: 4.5

- **Plataforma**: Android (ARM64)- ❌ **"¡TE ATROPELLARON! - Recuerda: siempre mira antes de cruzar"** (Rojo)- **Salto automático**: Sube escalones hasta 1m de altura3. Configura tu keystore para firmar la aplicación

- **Renderizado**: Mobile (gl_compatibility)

- **XR**: Native mobile interface  - Mensaje educativo tras colisión

- **Resolución**: 1920x1080

  - Refuerza el aprendizaje- **Colisiones**: No puedes atravesar árboles u objetos4. Instala las plantillas de exportación de Android si es necesario

### Sistemas Implementados

- **CharacterBody3D**: Para el jugador con colisiones físicas

- **Raycast**: Detección de gaze para botones del menú

- **Trimesh Collision**: Colisiones automáticas del escenario Blender#### Sistema de Seguridad5. Exporta el APK

- **Area3D**: Zonas de meta y cruces peatonales

- **Label3D**: UI en 3D con billboard- **Detección de atropello**: Si el jugador cruza con vehículos en movimiento

- **Sistema de tráfico**: Vehículos autónomos con IA simple

- **StaticBody3D**: Bordes invisibles del escenario- **Respawn seguro**: Regresa al jugador a posición segura tras atropello (3 segundos)### ✅ Sistema de Final de Juego



### Parámetros Ajustables- **Pausa educativa**: Muestra mensaje durante 5 segundos para reforzar el aprendizaje



#### Jugador (continuous_movement.gd)- **Gestor de tráfico**: Coordina vehículos, mensajes y seguridad del cruce- Zona de meta configurable## Características incluidas

```gdscript

move_speed: 3.75           # Velocidad de movimiento (m/s)

gravity: 20.0              # Gravedad

jump_force: 5.0            # Fuerza de salto automático### ✅ Sistema de Final de Juego- Pausa de 1.5 segundos al llegar (evita reinicio accidental)

max_step_height: 1.0       # Altura máxima de escalón (metros)

end_menu_delay: 1.5        # Retraso antes de interactuar con menú final- Zona de meta configurable

```

- Pausa de 1.5 segundos al llegar (evita reinicio accidental)- Menú de victoria con opciones:- ✅ Configuración básica de XR

#### Vehículo (vehicle.gd)

```gdscript- Menú de victoria con opciones:

speed: 5.0                 # Velocidad del vehículo (m/s)

start_position: Vector3    # Se toma automáticamente del transform 3D  - **REINICIAR**: Vuelve al inicio del nivel  - **REINICIAR**: Vuelve al inicio del nivel- ✅ Cámara VR a altura de ojos (1.7m)

end_position: Vector3      # Posición final del recorrido

auto_restart: false        # No reiniciar automáticamente  - **MENU PRINCIPAL**: Regresa al menú de inicio

auto_start: false          # No iniciar al cargar

collision_layer: 0         # Sin colisiones con el mundo- Indicador visual de estado (cursor amarillo → blanco → verde)  - **MENU PRINCIPAL**: Regresa al menú de inicio- ✅ Iluminación direccional con sombras

collision_mask: 0          # Solo detecta jugador con Area3D

```



#### Zona de Cruce (crossing_zone.gd)---- Indicador visual de estado (cursor amarillo → blanco → verde)- ✅ Suelo y cubo de prueba

- Tamaño base: BoxShape3D (20x3x10)

- Escala configurable desde el editor

- Posición ajustable en tiempo real

## 🗂️ Estructura del Proyecto- ✅ Script de inicialización VR

#### Mensajes de Seguridad (safety_messages.gd)

```gdscript

pixel_size: 0.006          # Tamaño del texto en VR

billboard: ENABLED         # Siempre mira al jugador```---- ✅ Configuración de exportación para Android

outline_size: 8            # Borde negro para legibilidad

```vr/



---├── scenes/



## 📱 Exportar a Android│   ├── menu.tscn              # Menú principal VR



### Requisitos Previos│   └── main.tscn              # Escena del juego## 🗂️ Estructura del Proyecto## Próximos pasos

1. Android SDK instalado

2. Plantillas de exportación de Godot 4.5├── scripts/

3. Certificado de depuración configurado

│   ├── menu_vr.gd             # Lógica del menú (gaze + touch)

### Pasos para Exportar

│   ├── continuous_movement.gd # Movimiento, colisiones y fin de juego

1. **Abrir configuración de exportación:**

   - `Proyecto → Exportar → Android`│   ├── finish_zone.gd         # Detector de zona de meta```1. Importa tu escenario de Blender



2. **Configuración importante:**│   ├── end_game_menu.gd       # Menú de victoria

   - ✅ **XR Mode**: `1` (Obligatorio para VR)

   - ✅ **Permissions**: `CAMERA` (para VR)│   ├── add_collisions.gd      # Generador automático de colisionesvr/2. Añade mecánicas de juego (interacciones, objetivos, etc.)

   - ✅ **Screen Orientation**: `Landscape`

   - ✅ **Min SDK**: `24` (Android 7.0)│   ├── vehicle.gd             # Vehículo autónomo con detección de colisión

   - ✅ **Target SDK**: `33`

│   ├── crossing_zone.gd       # Zona de cruce peatonal├── scenes/3. Optimiza para móvil (reduce polígonos, usa texturas comprimidas)

3. **Configurar ruta del SDK:**

   - En "Editor Settings → Export → Android"│   ├── safety_messages.gd     # Sistema de mensajes educativos en VR

   - Establecer ruta: `D:/SDK` (o tu ruta personalizada)

│   └── crossing_manager.gd    # Gestor de tráfico y educación vial│   ├── menu.tscn              # Menú principal VR4. Añade un sistema de mirada para interactuar (gaze-based interaction)

4. **Exportar:**

   - Click en "Exportar Proyecto"├── models/

   - Seleccionar ubicación para el APK

   - Click en "Guardar"│   └── EscenarioPrincipal.glb # Escenario 3D de Blender│   └── main.tscn              # Escena del juego5. Implementa audio espacial para mayor inmersión



5. **Instalar en dispositivo:**├── project.godot              # Configuración del proyecto

   - Conectar dispositivo Android con USB

   - Habilitar "Depuración USB" en opciones de desarrollador└── README.md                  # Este archivo├── scripts/

   - Instalar APK: `adb install proyecto.apk`

```

---

│   ├── menu_vr.gd             # Lógica del menú (gaze + touch)## Controles en Google Cardboard

## 🎓 Guía de Uso - Sistema de Educación Vial

---

### Para Profesores/Educadores

│   ├── continuous_movement.gd # Movimiento, colisiones y fin de juego

Este proyecto puede usarse como herramienta educativa para enseñar:

## 🎮 Controles

1. **Conciencia Peatonal Básica**

   - Observar antes de cruzar│   ├── finish_zone.gd         # Detector de zona de meta- **Mirar alrededor**: Mueve la cabeza

   - Respetar los vehículos en movimiento

   - Esperar en la acera hasta que sea seguro### En Dispositivo Móvil (VR):

   - Mirar a ambos lados antes de avanzar

- **Girar cabeza**: Mirar alrededor│   ├── end_game_menu.gd       # Menú de victoria- **Interactuar**: Apunta con la mirada y usa el botón de Cardboard (o toca la pantalla)

2. **Consecuencias de Acciones Inseguras**

   - El atropello es una experiencia inmersiva pero segura- **Mantener touch en pantalla**: Moverse hacia adelante

   - Los mensajes refuerzan el aprendizaje

   - El respawn permite intentarlo nuevamente con más conocimiento- **Mirar botón + touch**: Activar botón del menú│   └── add_collisions.gd      # Generador automático de colisiones

   - Sistema de retroalimentación inmediata

- **Observar el tráfico**: Importante para cruzar calles de forma segura

3. **Refuerzo Positivo**

   - Mensajes verdes cuando se cruza correctamente├── models/## Notas importantes

   - Felicitación al completar el nivel de forma segura

   - Sistema de recompensa visual (completar el juego)### En Editor de Godot (Pruebas):



### Personalización del Sistema- **Click izquierdo**: Capturar mouse│   └── EscenarioPrincipal.glb # Escenario 3D de Blender



#### Agregar Más Vehículos- **Mover mouse**: Rotar cámara

1. En `main.tscn`, duplicar el nodo `TrafficSystem/Vehicle` o `Vehicle2`

2. Posicionar en el editor 3D (la posición inicial se toma automáticamente)- **Click derecho (mantener)**: Moverse├── project.godot              # Configuración del proyecto- Google Cardboard usa 3DOF (3 grados de libertad: solo rotación, sin posición)

3. Modificar solo `end_position` en el inspector

4. Ajustar `speed` para variar la dificultad- **ESC**: Liberar cursor

5. El vehículo se agregará automáticamente al sistema (grupo "vehicle")

└── README.md                  # Este archivo- Mantén un framerate alto (60+ FPS) para evitar mareos

#### Cambiar Posición de la Zona de Cruce

1. Seleccionar `TrafficSystem/CrossingZone` en el editor---

2. Mover a la posición deseada en tu escenario (usar transform 3D)

3. Ajustar el `CollisionShape3D` para cubrir el ancho de la calle```- Usa colores suaves y evita movimientos bruscos de cámara

4. Actualizar `end_position` de los vehículos para que crucen esa zona

## ⚙️ Configuración Técnica

#### Ajustar Bordes Invisibles

1. Seleccionar nodos `InvisibleBoundaries/Boundary*`- La batería del móvil se descarga rápido, optimiza bien

2. Mover en el editor 3D según el tamaño de tu escenario

3. Ajustar escala del `CollisionShape3D` si es necesario### Motor y Plataforma



#### Personalizar Mensajes Educativos- **Godot**: 4.5---

1. Abrir `scripts/safety_messages.gd`

2. Modificar el diccionario `MESSAGES`- **Plataforma**: Android (ARM64)

3. Agregar nuevos mensajes según necesites

- **Renderizado**: Mobile (gl_compatibility)## 🎮 Controles

```gdscript

const MESSAGES = {- **XR**: Native mobile interface

    "custom": "Tu mensaje personalizado aquí",

    "otro": "Otro mensaje educativo"### En Dispositivo Móvil (VR):

}

```### Sistemas Implementados- **Girar cabeza**: Mirar alrededor



---- **CharacterBody3D**: Para el jugador con colisiones- **Mantener touch en pantalla**: Moverse hacia adelante



## 🐛 Debugging y Desarrollo- **Raycast**: Detección de gaze para botones- **Mirar botón + touch**: Activar botón del menú



### Mensajes de Consola- **Trimesh Collision**: Colisiones automáticas del escenario

El sistema imprime información útil para debugging:

- `🚗 Vehículo iniciado en posición: ... → distancia total: ...m`- **Area3D**: Zonas de meta y cruces peatonales### En Editor de Godot (Pruebas):

- `🚗 Vehículo llegó al final en posición: ...`

- `🚸 Jugador entró a la zona de cruce`- **Label3D**: UI en 3D- **Click izquierdo**: Capturar mouse

- `🚦 Jugador en zona de cruce. Seguro: true/false`

- `🚦 Vehículos iniciados - el jugador entró a la zona de cruce`- **Sistema de tráfico**: Vehículos autónomos con IA simple- **Mover mouse**: Rotar cámara

- `💥 ¡JUGADOR ATROPELLADO!`

- `💬 Mostrando mensaje: ...`- **Click derecho (mantener)**: Moverse

- `🔄 Jugador reiniciado en posición segura`

- `🔄 Reiniciando sistema de tráfico...`### Parámetros Ajustables- **ESC**: Liberar cursor



### Tips de Desarrollo

1. ✅ Usa el modo editor para probar sin VR

2. ✅ Los mensajes de consola ayudan a detectar problemas#### Jugador (continuous_movement.gd)---

3. ✅ Ajusta `move_speed` y `vehicle.speed` para balancear dificultad

4. ✅ Los vehículos se posicionan automáticamente desde el editor 3D```gdscript

5. ✅ Solo necesitas configurar `end_position` para nuevos vehículos

6. ✅ Puedes mover vehículos en el editor sin editar códigomove_speed: 3.75           # Velocidad de movimiento## ⚙️ Configuración Técnica



### Problemas Comunesgravity: 20.0              # Gravedad



#### El jugador no detecta atropellosjump_force: 5.0            # Fuerza de salto automático### Motor y Plataforma

- ✅ Verificar que `Vehicle/Area3D` tenga `CollisionShape3D`

- ✅ Asegurar que el jugador esté en el grupo "player"max_step_height: 1.0       # Altura máxima de escalón- **Godot**: 4.5

- ✅ Revisar que `crossing_manager.gd` esté conectado correctamente

- ✅ Confirmar que vehículos estén en el grupo "vehicle"```- **Plataforma**: Android (ARM64)



#### Los mensajes no aparecen- **Renderizado**: Mobile (gl_compatibility)

- ✅ Verificar que `SafetyMessages/MessageLabel` exista

- ✅ Confirmar que `pixel_size` no sea demasiado pequeño (usar 0.006)#### Vehículo (vehicle.gd)- **XR**: Native mobile interface

- ✅ Asegurar que la cámara esté correctamente referenciada

- ✅ Revisar que billboard esté habilitado```gdscript



#### Vehículos no se muevenspeed: 5.0                 # Velocidad del vehículo (m/s)### Sistemas Implementados

- ✅ Verificar `end_position` en el inspector

- ✅ Confirmar que el script `vehicle.gd` esté asignadostart_position: Vector3    # Posición inicial- **CharacterBody3D**: Para el jugador con colisiones

- ✅ Entrar a la zona de cruce para activar el tráfico

- ✅ Revisar mensajes de consola para erroresend_position: Vector3      # Posición final- **Raycast**: Detección de gaze para botones



#### Vehículos se detienen antes de tiempoauto_restart: true         # Reiniciar automáticamente- **Trimesh Collision**: Colisiones automáticas del escenario

- ✅ Sistema actualizado: ahora usan movimiento directo sin física

- ✅ No colisionan con el terreno (`collision_layer = 0`)```- **Area3D**: Zona de meta

- ✅ Verifican distancia recorrida además de posición

- ✅ Margen de llegada de 2 metros- **Label3D**: UI en 3D



#### Los vehículos no se reinician#### Zona de Cruce (crossing_zone.gd)

- ✅ Verificar que `reset_traffic_system()` se llame en `_on_restart_game()`

- ✅ Confirmar que se llame también en `respawn_player()` tras atropello- Configurable mediante BoxShape3D en el editor### Parámetros Ajustables

- ✅ Revisar mensajes de consola: "🔄 Reiniciando sistema de tráfico..."

- Tamaño recomendado: 20x3x10 metros```gdscript

#### El jugador se sale del mapa

- ✅ Verificar que los nodos `InvisibleBoundaries/Boundary*` existanmove_speed: 3.75           # Velocidad de movimiento

- ✅ Ajustar posiciones de bordes según tu escenario

- ✅ Confirmar que sean `StaticBody3D` con `CollisionShape3D`---gravity: 20.0              # Gravedad



---jump_force: 5.0            # Fuerza de salto automático



## 🚀 Próximos Pasos / Ideas de Expansión## 📱 Exportar a Androidmax_step_height: 1.0       # Altura máxima de escalón



### Completado ✅```

- [x] Sistema de vehículos autónomos

- [x] Detección de zonas de cruce### Requisitos Previos

- [x] Mensajes educativos en VR

- [x] Respawn tras atropello con reinicio de tráfico1. Android SDK instalado---

- [x] Dos vehículos en direcciones opuestas (mismo sentido, 2 carriles)

- [x] Vehículos inician solo cuando jugador entra a zona2. Plantillas de exportación de Godot 4.5

- [x] Recorrido único (no se reinician automáticamente)

- [x] Vehículos sin colisiones con terreno3. Certificado de depuración configurado## 📱 Exportar a Android

- [x] Posicionamiento automático desde editor 3D

- [x] Reinicio completo del sistema al presionar "REINICIAR"

- [x] Bordes invisibles para contener al jugador

### Pasos para Exportar### Requisitos Previos

### Nivel Intermedio (Ideas Futuras)

- [ ] Múltiples zonas de cruce en el mapa1. Android SDK instalado

- [ ] Vehículos con velocidades aleatorias

- [ ] Semáforos interactivos1. **Abrir configuración de exportación:**2. Plantillas de exportación de Godot 4.5

- [ ] Pasos peatonales marcados visualmente

- [ ] Sistema de puntuación por cruces seguros   - `Proyecto → Exportar → Android`3. Certificado de depuración configurado

- [ ] Contador de intentos/atropellos

- [ ] Logros y recompensas



### Nivel Avanzado (Ideas Futuras)2. **Configuración importante:**### Pasos para Exportar

- [ ] Diferentes tipos de vehículos (autos, motos, bicicletas, buses)

- [ ] Condiciones climáticas (lluvia, niebla)   - ✅ **XR Mode**: `1` (Obligatorio)

- [ ] Ciclo día/noche

- [ ] Cruces con curvas y esquinas   - ✅ **Permissions**: `CAMERA` (para VR)1. **Abrir configuración de exportación:**

- [ ] Peatones NPC que dan ejemplo

- [ ] Modo multijugador educativo   - ✅ **Screen Orientation**: `Landscape`   - `Proyecto → Exportar → Android`

- [ ] Estadísticas de seguridad al final del juego

- [ ] Mini-juegos educativos adicionales   - ✅ **Min SDK**: `24` (Android 7.0)

- [ ] Niveles de dificultad (fácil, medio, difícil)

   - ✅ **Target SDK**: `33`2. **Configuración importante:**

---

   - ✅ **XR Mode**: `1` (Obligatorio)

## 📚 Recursos Adicionales

3. **Configurar ruta del SDK:**   - ✅ **Permissions**: `CAMERA` (para VR)

### Documentación de Godot

- [Godot XR Documentation](https://docs.godotengine.org/en/stable/tutorials/xr/index.html)   - En "Editor Settings → Export → Android"   - ✅ **Screen Orientation**: `Landscape`

- [CharacterBody3D](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html)

- [Area3D](https://docs.godotengine.org/en/stable/classes/class_area3d.html)   - Establecer ruta: `D:/SDK` (o tu ruta personalizada)   - ✅ **Architecture**: `arm64-v8a`

- [StaticBody3D](https://docs.godotengine.org/en/stable/classes/class_staticbody3d.html)



### Google Cardboard

- [Google Cardboard Developer Guide](https://developers.google.com/cardboard)4. **Exportar:**3. **Exportar:**

- [VR Best Practices](https://developer.oculus.com/resources/design-intro/)

   - Click en "Exportar Proyecto"   - Click en "Exportar Proyecto"

### Educación Vial

- Organización Mundial de la Salud - [Seguridad Vial](https://www.who.int/health-topics/road-safety)   - Seleccionar ubicación para el APK   - Guardar como APK

- [Consejos de Seguridad Peatonal](https://www.nhtsa.gov/road-safety/pedestrian-safety)

   - Click en "Guardar"   - Instalar en dispositivo Android

---



## 📄 Licencia

---### Requisitos del Dispositivo

Este proyecto es de código abierto y puede ser usado con fines educativos.

- Android 7.0 o superior

---

## 🎓 Guía de Uso - Sistema de Educación Vial- Giroscopio (para seguimiento de cabeza)

## 👨‍💻 Información del Proyecto

- Google Cardboard o visor compatible

**Autor:** Diego Armando Sanchez Rubio  

**Fecha:** 2024  ### Para Profesores/Educadores

**Motor:** Godot 4.5  

**Propósito:** Educación vial en realidad virtual  ---

**Plataforma:** Android (Google Cardboard)  

**Tipo:** Juego Educativo VREste proyecto puede usarse como herramienta educativa para enseñar:



---## 🎯 Cómo Jugar



## 🙏 Agradecimientos1. **Conciencia Peatonal Básica**



- Godot Engine por proporcionar un motor gratuito y potente   - Observar antes de cruzar1. **Inicio:**

- Google Cardboard por democratizar la realidad virtual

- Comunidad de desarrolladores VR por compartir conocimientos   - Respetar los vehículos en movimiento   - Abre la aplicación en tu dispositivo



---   - Esperar en la acera hasta que sea seguro   - Coloca el teléfono en el Google Cardboard



**¡Disfruta aprendiendo educación vial en realidad virtual! 🚗🚸✅**   - Verás el menú principal


2. **Consecuencias de Acciones Inseguras**

   - El atropello es una experiencia inmersiva pero segura2. **Menú:**

   - Los mensajes refuerzan el aprendizaje   - Mira el botón "INICIAR JUEGO" → Se pondrá verde

   - El respawn permite intentarlo nuevamente con más conocimiento   - Toca la pantalla para iniciar



3. **Refuerzo Positivo**3. **Juego:**

   - Mensajes verdes cuando se cruza correctamente   - Mira hacia donde quieres ir

   - Felicitación al completar el nivel de forma segura   - Mantén presionada la pantalla para moverte

   - Suelta para detenerte

### Personalización del Sistema   - Automáticamente saltarás escalones pequeños



#### Agregar Más Vehículos4. **Meta:**

1. En `main.tscn`, duplicar el nodo `TrafficSystem/Vehicle`   - Llega al final del escenario

2. Modificar `start_position` y `end_position` para crear nuevas rutas   - Espera 1.5 segundos (cursor amarillo)

3. Ajustar `speed` para variar la dificultad   - Selecciona REINICIAR o MENU PRINCIPAL



#### Cambiar Posición de la Zona de Cruce---

1. Seleccionar `TrafficSystem/CrossingZone` en el editor

2. Mover a la posición deseada en tu escenario## 🛠️ Desarrollo y Debugging

3. Ajustar el `CollisionShape3D` para cubrir el ancho de la calle

### Probar en el Editor

#### Personalizar Mensajes Educativos```

1. Abrir `scripts/safety_messages.gd`F5: Ejecutar proyecto (menú)

2. Modificar el diccionario `MESSAGES`F6: Ejecutar escena actual

3. Agregar nuevos mensajes según necesites```



```gdscript### Logs Útiles

const MESSAGES = {```

    "custom": "Tu mensaje personalizado aquí"✓ VR inicializado

}Posición Y: X.X | En suelo: true | En pared: false

```>>> Mirando: StartButton <<<

¡¡¡JUEGO COMPLETADO!!!

---*** MENÚ LISTO - Ahora puedes seleccionar una opción ***

```

## 🐛 Debugging y Desarrollo

### Ajustar Posición de Meta

### Mensajes de ConsolaEn `main.tscn`, modifica la posición Z de `FinishZone`:

El sistema imprime información útil para debugging:```gdscript

- `🚗 Vehículo iniciado en posición: ...`[node name="FinishZone" type="Area3D" parent="."]

- `🚸 Jugador entró a la zona de cruce`transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, -20)

- `🚦 Jugador en zona de cruce. Seguro: true/false`                                                      #    ↑ Cambiar Z

- `💥 ¡JUGADOR ATROPELLADO!````

- `💬 Mostrando mensaje: ...`

---

### Tips de Desarrollo

1. Usa el modo editor para probar sin VR## 📝 Notas de Desarrollo

2. Los mensajes de consola ayudan a detectar problemas

3. Ajusta `move_speed` y `vehicle.speed` para balancear dificultad### Características Implementadas

4. Puedes deshabilitar `auto_restart` en vehículos para pruebas- ✅ Menú VR con detección de gaze

- ✅ Movimiento continuo basado en vista

### Problemas Comunes- ✅ Colisiones con escenario

- ✅ Salto automático de escalones

#### El jugador no detecta atropellos- ✅ Sistema de fin de juego

- Verificar que `Vehicle/Area3D` tenga CollisionShape3D- ✅ Reinicio y navegación de menús

- Asegurar que el jugador esté en el grupo "player"- ✅ Controles de mouse para debugging

- Revisar que `crossing_manager.gd` esté conectado correctamente

### Optimizaciones

#### Los mensajes no aparecen- Colisiones generadas automáticamente

- Verificar que `SafetyMessages/MessageLabel` exista- Raycast optimizado (excluye jugador y áreas)

- Confirmar que `pixel_size` no sea demasiado pequeño- Retraso anti-accidente en menú final

- Asegurar que la cámara esté correctamente referenciada- Gravedad y física ajustadas para VR



#### Vehículos no se mueven---

- Verificar `start_position` y `end_position` en el inspector

- Confirmar que el script `vehicle.gd` esté asignado## 🐛 Solución de Problemas

- Revisar que `is_moving` se active en `_ready()`

**El jugador se cae infinitamente:**

---- Verifica que el escenario tenga colisiones (trimesh)

- Ajusta la posición inicial Y del CharacterBody3D


---**¡Disfruta el juego! 🎮✨**


## 📚 Recursos Adicionales

### Documentación de Godot
- [Godot XR Documentation](https://docs.godotengine.org/en/stable/tutorials/xr/index.html)
- [CharacterBody3D](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html)
- [Area3D](https://docs.godotengine.org/en/stable/classes/class_area3d.html)

### Google Cardboard
- [Google Cardboard Developer Guide](https://developers.google.com/cardboard)
- [VR Best Practices](https://developer.oculus.com/resources/design-intro/)

---

## 📄 Licencia

Este proyecto es de código abierto y puede ser usado con fines educativos.

**Autor:** Diego Armando Sanchez Rubio  
**Fecha:** 2025  
**Motor:** Godot 4.5  
**Propósito:** Educación vial en realidad virtual


