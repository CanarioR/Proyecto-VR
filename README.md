# Aprendiendo a Cruzar la Calle

**Proyecto de Educación Vial en Realidad Virtual**

Experiencia educativa en VR diseñada para Google Cardboard que enseña seguridad peatonal mediante la simulación de cruces de calle con tráfico vehicular.

**Autor:** Diego Armando Sanchez Rubio

---

## 📋 Descripción

Juego educativo de realidad virtual que simula múltiples cruces de calle con tráfico vehicular. El jugador debe aprender a cruzar de forma segura, observando el tráfico y esperando el momento adecuado. El sistema proporciona retroalimentación educativa en tiempo real sobre la seguridad peatonal.

**Características principales:**
- 🚗 **Sistema de tráfico escalonado**: 3 zonas de cruce independientes con 6 vehículos de diferentes colores
- 🎯 **Activación por proximidad**: Los vehículos solo se mueven cuando llegas a cada zona específica
- 📢 **Mensajes educativos**: Indicadores visuales de seguridad codificados por color
- 🔄 **Sistema de reinicio completo**: Resetea todas las zonas al reiniciar o después de un atropello
- 🎮 **Control VR intuitivo**: Movimiento continuo con Google Cardboard
- 🏆 **Objetivo claro**: Llegar al final sin ser atropellado

---

## 🎮 Controles

- **Mantener pulsado** el botón magnético de Google Cardboard para avanzar
- **Mirar hacia la dirección** en la que deseas moverte
- **Soltar el botón** para detenerte inmediatamente

---

## 🚦 Mecánicas de Juego

### Sistema de Tráfico Escalonado

El juego presenta **3 zonas de cruce** distribuidas a lo largo del escenario:

1. **Primera Zona** - Vehículos rojo y azul (velocidad: 5 m/s)
2. **Segunda Zona** - Vehículos verde y amarillo (velocidad: 5.5 m/s)
3. **Tercera Zona** - Vehículos naranja y morado (velocidad: 6 m/s)

**Funcionamiento:**
- Los vehículos de cada zona **solo inician** cuando el jugador entra en esa zona de cruce específica
- Los vehículos avanzan hasta el final de su trayecto y **se detienen**
- No hay reinicio automático de vehículos (pase único por zona)
- Cada zona es independiente de las demás

### Mensajes Educativos

El sistema muestra mensajes codificados por color según la situación:

- 🔴 **DETENTE** (Rojo) - Hay vehículos en movimiento cerca
- 🟡 **MIRA A AMBOS LADOS** (Amarillo) - Entrando a la zona de cruce
- 🟢 **SEGURO CRUZAR** (Verde) - No hay vehículos en movimiento
- 🟠 **¡PELIGRO!** (Naranja) - Vehículo aproximándose
- 🔴 **¡ATROPELLADO!** (Rojo brillante) - Colisión con vehículo

### Sistema de Reinicio

El juego se reinicia completamente en dos situaciones:

1. **Botón REINICIAR**: Presionando el botón en el menú de fin de juego
2. **Atropello**: Cuando el jugador es golpeado por un vehículo

**Al reiniciar:**
- Todos los 6 vehículos vuelven a su posición inicial
- Todas las zonas de cruce se resetean
- El jugador regresa a la posición de inicio
- Los mensajes educativos se ocultan

---

## 🏗️ Estructura del Proyecto

```
vr/
├── scenes/
│   ├── menu.tscn           # Menú principal VR
│   └── main.tscn           # Escena principal del juego
├── scripts/
│   ├── continuous_movement.gd      # Sistema de movimiento del jugador
│   ├── crossing_manager.gd        # Gestor de tráfico y educación vial
│   ├── crossing_zone.gd           # Zona de detección de cruce
│   ├── vehicle.gd                 # Comportamiento de vehículos
│   ├── safety_messages.gd         # Sistema de mensajes educativos
│   ├── initial_instructions.gd    # Instrucciones al inicio
│   ├── finish_zone.gd             # Zona de meta
│   ├── end_game_menu.gd           # Menú de fin de juego
│   ├── add_collisions.gd          # Generador de colisiones
│   └── menu_vr.gd                 # Lógica del menú VR
├── models/
│   └── EscenarioPrincipal.glb     # Modelo 3D del escenario
├── export_presets.cfg              # Configuración de exportación
├── project.godot                   # Configuración del proyecto
└── README.md                       # Este archivo
```

---

## 🔧 Componentes Técnicos

### TrafficSystem (Sistema de Tráfico)

Cada uno de los 3 sistemas de tráfico contiene:

- **CrossingManager**: Coordina vehículos, zonas y mensajes
- **CrossingZone** (Area3D): Detecta entrada/salida del jugador
- **Vehicle** × 2: Dos vehículos que circulan por la zona
- **Referencia a SafetyMessages**: Sistema compartido de mensajes

**Características de los vehículos:**
- Sin colisión con terreno (`collision_layer = 0`, `collision_mask = 0`)
- Movimiento directo mediante posición (`velocity * delta`)
- Verificación dual de llegada: distancia < 2m O traveled_distance >= total_distance
- Posición inicial automática desde el editor 3D
- Detección de colisión con jugador mediante Area3D

### CrossingManager

**Responsabilidades:**
- Detectar solo los vehículos hijos de su TrafficSystem padre
- Iniciar vehículos cuando el jugador entra a la zona (primera vez únicamente)
- Monitorear seguridad del cruce en tiempo real
- Mostrar mensajes educativos apropiados
- Gestionar atropellos y respawn del jugador
- Resetear estado del sistema cuando se solicita

**Variables clave:**
- `vehicles_started: bool` - Controla si los vehículos ya iniciaron
- `is_safe_to_cross: bool` - Indica si no hay vehículos en movimiento
- `player_in_crossing: bool` - El jugador está en la zona de cruce
- `has_been_hit: bool` - Evita múltiples detecciones de atropello

### Sistema de Reinicio Global

Función en `continuous_movement.gd` que reinicia todos los sistemas:

```gdscript
func reset_all_traffic_systems():
    var traffic_systems = [
        get_node_or_null("TrafficSystem/CrossingManager"),
        get_node_or_null("TrafficSystem2/CrossingManager"),
        get_node_or_null("TrafficSystem3/CrossingManager")
    ]
    
    for traffic_system in traffic_systems:
        if traffic_system and traffic_system.has_method("reset_traffic_system"):
            traffic_system.reset_traffic_system()
```

**Se llama desde:**
- `_on_restart_game()` - Botón REINICIAR
- `respawn_player()` en CrossingManager - Después de atropello

---

## 🎯 Flujo de Juego

1. **Inicio**: El jugador aparece en la posición inicial
   - Se muestran instrucciones que desaparecen después de 5 segundos
   - Objetivo: "Llegar hasta el otro lado sin ser atropellado"

2. **Primera Zona de Cruce**:
   - El jugador avanza y entra en la primera zona
   - Los vehículos rojo y azul comienzan a moverse
   - Aparece mensaje: "🟡 MIRA A AMBOS LADOS"

3. **Segunda Zona de Cruce**:
   - Al llegar, se activan vehículos verde y amarillo
   - Mayor velocidad = mayor dificultad

4. **Tercera Zona de Cruce**:
   - Última zona con vehículos naranja y morado
   - Máxima velocidad, requiere observación cuidadosa

5. **Meta**: Al llegar a la zona final
   - Aparece menú con opciones
   - "REINICIAR" o "MENÚ PRINCIPAL"

6. **Atropello**: Si un vehículo golpea al jugador
   - Mensaje educativo
   - Espera de 3 segundos
   - Reinicio completo del juego

---

## 🛠️ Requisitos Técnicos

- **Motor**: Godot 4.5+
- **Renderer**: Mobile (gl_compatibility)
- **XR**: Native Mobile Interface / OpenXR
- **Dispositivo**: Google Cardboard o compatible
- **Plataforma**: Android 5.0 o superior
- **Espacio**: ~50 MB

---

## 📱 Configuración VR

El proyecto está configurado para:
- **Interfaz XR**: Native Mobile (Android) / OpenXR (Editor con visor)
- **Modo de renderizado**: Compatible con móviles
- **Vista estereoscópica**: Activada automáticamente en Android
- **Orientación**: Landscape
- **Permisos Android**: Cámara (para VR)

### Vista Estereoscópica

**En Android:**
- ✅ Se muestra automáticamente al exportar el APK
- ✅ Dos pantallas divididas para Google Cardboard
- ✅ Sin configuración adicional requerida

**En Editor de Godot:**
- ⚠️ Requiere visor VR conectado o SteamVR instalado
- ⚠️ Sin visor VR, solo se ve una pantalla (para testing)
- ℹ️ La vista estereoscópica funciona 100% en el dispositivo Android

---

## 📦 Exportación a Android

### Configuración del Proyecto

El proyecto ya está configurado con:
- ✅ Nombre: "Aprendiendo a Cruzar la Calle"
- ✅ Package ID: `com.diegosanchez.aprendiendoacruzar`
- ✅ Versión: 1.0
- ✅ XR Mode habilitado
- ✅ Permisos necesarios configurados

### Pasos para Exportar

1. **Abre Godot** y carga el proyecto
2. **Ve a Proyecto > Exportar**
3. **Selecciona "Android"**
4. **Verifica la configuración**:
   - Architecture: ARM64-v8a ✅
   - XR Mode: 1 (OpenXR) ✅
5. **Exporta el proyecto**
6. **Instala el APK** en tu dispositivo Android
7. **¡Disfruta la experiencia VR!**

---

## 🎓 Propósito Educativo

Este proyecto fue desarrollado como herramienta educativa para enseñar seguridad vial a través de realidad virtual. El sistema escalonado permite un aprendizaje progresivo:

1. **Primera zona**: Introducción al sistema de tráfico
2. **Segunda zona**: Aumento de dificultad (velocidad)
3. **Tercera zona**: Aplicación de conocimientos adquiridos

Los mensajes educativos codificados por color refuerzan el aprendizaje visual y proporcionan retroalimentación inmediata sobre las decisiones del jugador.

---

## 🔄 Historial de Versiones

### v2.0 - Sistema Escalonado (Actual)
- ✅ 3 zonas de cruce independientes con 6 vehículos
- ✅ Activación por proximidad (cada zona se activa al llegar)
- ✅ Sistema de reinicio global para todas las zonas
- ✅ Velocidades progresivas (5.0 → 5.5 → 6.0 m/s)
- ✅ 6 materiales de vehículos (rojo, azul, verde, amarillo, naranja, morado)
- ✅ Vista estereoscópica configurada para Android
- ✅ Proyecto listo para exportar a Google Cardboard

### v1.0 - Sistema Básico
- ✅ Sistema de tráfico con 2 vehículos
- ✅ Mensajes educativos de seguridad
- ✅ Movimiento continuo en VR
- ✅ Detección de atropellos
- ✅ Sistema de respawn
- ✅ Límites invisibles del escenario
- ✅ Instrucciones iniciales con fade out

---

## 🚀 Próximas Mejoras Sugeridas

- [ ] Diferentes tipos de vehículos (autos, motos, buses)
- [ ] Semáforos funcionales
- [ ] Sistema de puntuación basado en seguridad
- [ ] Diferentes escenarios (ciudad, zona escolar, etc.)
- [ ] Modo tutorial paso a paso
- [ ] Sonidos de tráfico y ambiente urbano
- [ ] Efectos visuales adicionales (sombras de vehículos, partículas)
- [ ] Múltiples niveles de dificultad

---

## 👨‍💻 Créditos

**Desarrollador**: Diego Armando Sanchez Rubio

**Motor de Juego**: Godot Engine 4.5

**Plataforma**: Android - Google Cardboard

**Tecnologías Utilizadas**:
- Godot XR Native Mobile Interface
- GDScript para programación
- Renderizado móvil (gl_compatibility)
- Sistema de colisiones 3D
- Sistema de mensajes educativos personalizados

**Tipo de Proyecto**: Educativo - Académico

**Año**: 2025

---

## 📄 Licencia

Proyecto educativo desarrollado para propósitos académicos.

**Nota**: Este juego es una herramienta educativa y no sustituye la educación vial formal ni el entrenamiento práctico supervisado.

---

## 🔗 Enlaces

- **Motor Godot**: https://godotengine.org/
- **Google Cardboard**: https://arvr.google.com/cardboard/
- **Documentación Godot XR**: https://docs.godotengine.org/en/stable/tutorials/xr/

---

## Creditos 

**Diego Armando Sanchez Rubio**

---

*¡Aprende a cruzar la calle de forma segura con realidad virtual!* 🚗🚸
