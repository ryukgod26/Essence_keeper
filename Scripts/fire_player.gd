extends CharacterBody2D

var enemy_inattack_range:bool = false
var enemy_attack_cooldown:bool = true
var health:int = 100
var player_alive:bool = true
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var attacking:bool = false
@onready var enemy_attack_cooldown_timer: Timer = $enemy_attack_cooldown
@export var inv :Inv
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var alive:bool = true
var can_attack:bool = true
@onready var player_attack_timer: Timer = $player_attack_timer
var is_charging:bool
var held_attack_fired:bool
var charge_time:float
const HELD_ATTACK_THRESHOLD:float = 2.0

signal health_changed(HEALTH:int)

func _physics_process(delta: float) -> void:
	if not alive:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("Attack") and is_on_floor() and can_attack:
		is_charging = true
		held_attack_fired = false
		charge_time = 0.0
	if Input.is_action_just_released("Attack"):
		if is_charging and not held_attack_fired:
			normal_attack()
		is_charging = false
	if Input.is_action_pressed("Attack"):
		if is_charging and not  held_attack_fired:
			charge_time += delta
		if charge_time >= HELD_ATTACK_THRESHOLD:
			heavy_attack()
			held_attack_fired = true
			
	var direction := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if direction > 0 and is_on_floor() and not attacking:
		velocity.x = 0
		velocity.x = direction * SPEED
		animated_sprite.flip_h = false
		animated_sprite.play('Run')
	elif direction < 0 and is_on_floor() and not attacking:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = true
		animated_sprite.play('Run')
		
	elif direction == 0 and is_on_floor() and not attacking:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play('Idle')
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play('Jump')

	move_and_slide()
	enemy_attack()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method('enemy'):

		enemy_inattack_range  = true	


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method('enemy'):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown_timer.start()
		enemy_attack_cooldown = false
		check_health()
		
		print('Player took Damage.')
		
	
func check_health():
	health_changed.emit(health)
	if health <= 0:
		alive= false
		animated_sprite.play("Death")
		
func player():
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'Attack1' or animated_sprite.animation == 'Attack2':
		attacking = false


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method('enemy'):

		enemy_inattack_range  = true	

func _on_player_hitbox_area_exited(area: Area2D) -> void:
	if area.has_method('enemy'):
		enemy_inattack_range = false


func _on_enemy_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func normal_attack():
	animated_sprite.play('Attack1')
	attacking = true
	Global.player_current_attack = true
	can_attack = false
	player_attack_timer.start()

func heavy_attack():
	animated_sprite.play('Attack2')
	attacking = true
	Global.player_current_attack = true
	can_attack = false
	player_attack_timer.start()

func _on_player_attack_timer_timeout() -> void:
	can_attack = true
