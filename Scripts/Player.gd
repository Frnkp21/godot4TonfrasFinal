extends CharacterBody2D

@export var move_speed: float = 100  # Velocidad de movimiento en píxeles por segundo
@export var attack_speed: float = 100  # Velocidad de ataque en píxeles por segundo


var is_attacking: bool = false  # Variable booleana que indica si se está atacando o no

func _physics_process(delta: float) -> void:
	var motion: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		motion.x += 1
	elif Input.is_action_pressed("move_left"):
		motion.x -= 1

	if Input.is_action_pressed("move_down"):
		motion.y += 1
	elif Input.is_action_pressed("move_up"):
		motion.y -= 1

	motion = motion.normalized() * move_speed * delta
	move_and_collide(motion)


	# Determinar la animación a reproducir según la dirección del movimiento
	if motion != Vector2.ZERO:
		if abs(motion.x) > abs(motion.y):
			if motion.x > 0:
				# Movimiento hacia la derecha
				$AnimatedSprite.play("Walk_Right")
			else:
				# Movimiento hacia la izquierda
				$AnimatedSprite.play("Walk_Left")
		else:
			if motion.y > 0:
				# Movimiento hacia abajo
				$AnimatedSprite.play("Walk_Down")
			else:
				# Movimiento hacia arriba
				$AnimatedSprite.play("Walk_Up")
	else:
		# Si no se está moviendo, reproducir la animación de Idle
		$AnimatedSprite.play("Idle")


func _on_Area2D_body_entered(body: Node) -> void:
	# Aquí puedes manejar las colisiones con otros objetos
	pass
