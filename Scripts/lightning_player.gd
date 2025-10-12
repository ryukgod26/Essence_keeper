extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play('Jump')


	var direction := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if direction > 0 and is_on_floor():
		velocity.x = direction * SPEED
		animated_sprite.play('Run')
	elif direction < 0 and is_on_floor():
		velocity.x = direction * SPEED
		animated_sprite.flip_h = true
		animated_sprite.play('Run')
		
	elif direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play('Idle')
		

	move_and_slide()
