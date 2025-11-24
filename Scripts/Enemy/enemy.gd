class_name Enemy
extends CharacterBody2D

var player: CharacterBody2D = null
var alive = true
var health := 2
const ATTACK_RANGE = 60.0
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var attack_timer: Timer = $Node/AttackTimer

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

var attack_player:CharacterBody2D = null

func _physics_process(delta: float) -> void:
	if not alive:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player != null:
		var dist = global_position.distance_to(player.global_position)
		if dist < ATTACK_RANGE:
			attempt_attack()
		else:
			move_to_player(delta)
	
	move_and_slide()

func move_to_player(_delta):	
	if animated_sprite.animation == "Attack":
		velocity.x = 0
		return

	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * SPEED
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false
	
	animated_sprite.play("Idle")

func attempt_attack():
	if attack_timer.is_stopped():
		velocity.x = 0
		animated_sprite.play('Attack')
		attack_timer.start()
		if player.has_method("take_damage"):
			player.take_damage(1)


func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "Attack":
		animated_sprite.play("Idle")
	elif animated_sprite.animation == "Death":
		queue_free()

func take_damage(damage:int):
	health -= damage
	if health <= 0:
		animated_sprite.play('Death')
		alive = false
	
