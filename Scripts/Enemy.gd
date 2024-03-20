extends CharacterBody2D
class_name Enemy

var speed = 70
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("Walk")



func _on_detecting_area_body_entered(body):
	player = body
	player_chase = true


func _on_detecting_area_body_exited(body):
	player = null
	player_chase = false
