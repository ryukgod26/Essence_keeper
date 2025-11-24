class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash: Node2D = $Dash

@export var health := 5
@export var base_speed := 300.
@export var dash_speed := 800.
@export var dash_length := .1

var Enemies = []
var JUMP_VELOCITY = -400
signal health_changed(Health:int)
var SPEED:float = base_speed
var attacking

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	if not alive:
		return
	move_logic(delta)

var alive = true

func move_logic(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta

	var move_input := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	
	if Input.is_action_just_pressed("Attack"):
		var attack_name = "Attack1" if randi() % 2 == 0 else "Attack2"
		animated_sprite.play(attack_name)
		attack()
		attacking = true
		
	
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(dash_length)
	
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not attacking:
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= 0.5

	var current_speed = dash_speed if dash.is_dashing() else base_speed

	if not attacking:
		if move_input != 0:
			velocity.x = move_input * current_speed
			animated_sprite.flip_h = move_input < 0
		else:
			velocity.x = move_toward(velocity.x, 0, current_speed)
	_update_animations(move_input)

func _update_animations(input_axis):
	if attacking: 
		return

	if is_on_floor():
		if input_axis != 0:
			animated_sprite.play("Run")
		else:
			animated_sprite.play("Idle")
	else:
		if velocity.y < 0:
			animated_sprite.play("Jump")
		else:
			animated_sprite.play("Fall")
	
	
	move_and_slide()

func take_damage(Damage: int):
	health -=  Damage
	health_changed.emit(health)
	if health <= 0:
		animated_sprite.play('Death')
		alive = false

func attack():
	for enemy in Enemies:
		enemy.take_damage(1)

func _on_weapon_area_body_entered(body: Node2D) -> void:
	Enemies.append(body)


func _on_weapon_area_body_exited(body: Node2D) -> void:
	Enemies.erase(body)


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Attack1" or animated_sprite.animation == "Attack2":
		attacking = false
	elif animated_sprite.animation == "Death":
		get_tree().reload_current_scene()
