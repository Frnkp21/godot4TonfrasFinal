extends CharacterBody2D
class_name Enemy

var speed = 70
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false

var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("Idle")
	else:
		$AnimatedSprite2D.play("Walk")
		move_and_collide(Vector2(0,0))


func _on_detecting_area_body_entered(body):
	player = body
	player_chase = true


func _on_detecting_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true
		


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health -30
			$take_damage_cooldown.start()
			can_take_damage = false
			print ("slime health ",health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout():
	can_take_damage = true


func update_health():
	var healthbar = $healthbar

	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func _on_AnimatedSprite2D_animation_finished(animation):
	if animation == "Idle":
		$AnimatedSprite2D.play("Attack")
	elif animation == "Attack":
		$AnimatedSprite2D.play("Idle")
