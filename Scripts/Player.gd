extends CharacterBody2D

const speed = 100
var current_dir ="none"


var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false 

func _ready():
	$AnimatedSprite.play("idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive=false #agregar un menu de respawn o algo
		health = 0
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()


func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Right")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Right_Idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Left")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Left_Idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Up")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Up_Idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Down")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Down_Idle")


func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
	
func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite.play("Attack_Right")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite.play("Attack_Left")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite.play("Attack_Down")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite.play("Attack_Up")
			$deal_attack_timer.start()
		


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
