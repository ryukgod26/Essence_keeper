class_name Enemy
extends CharacterBody2D

var player: CharacterBody2D = null

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if player != null:
		move_to_player(delta)
	
	move_and_slide()

func move_to_player(_delta):	
	var direction = (player.global_position - global_position).normalized()


	velocity.x = direction.x * SPEED

	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false
