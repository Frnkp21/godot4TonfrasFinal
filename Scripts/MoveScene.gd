extends Area2D

var escena = "NuevaEscena"

func _ready():
	# Conectar el método _unhandled_input al evento "input"
	self.connect("input", self, "_unhandled_input", Array(InputEvent))

func _unhandled_input(event):
	# Verificar si el evento es de tipo KEY y si la tecla es la que deseas
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		cambiar_escena()

func cambiar_escena():
	# Cambiar la escena solo si el cuerpo del jugador está en el área
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			get_tree().change_scene_to_file("res://Scenes/" + escena + ".tscn")
			break  # Evitar cambiar la escena múltiples veces si hay varios cuerpos solapados
