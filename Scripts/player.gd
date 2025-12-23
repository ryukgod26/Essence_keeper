class_name Player
extends CharacterBody2D

enum STATE{
	FALL,
	FLOOR,
	JUMP,
	DOUBLE_JUMP,
	FLOAT,
	LEDGE_CLIMB,
	LEDGE_JUMP,
}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash: Node2D = $Dash

@export var health := 5
@export var base_speed := 300.
@export var dash_speed := 800.
@export var dash_length := .1

const FALL_GRAVITY = 1500.
const FALL_VELOCITY = 500.
const WALK_VELOCITY = 300.

var Enemies = []
var JUMP_VELOCITY = -400
signal health_changed(Health:int)
var SPEED:float = base_speed
var attacking
var active_state: STATE

func _ready() -> void:
	change_state(STATE.FALL)

func _physics_process(delta: float) -> void:
	process_state(delta)
	move_and_slide()

var alive = true

func move_logic():
	var move_input := signf(Input.get_axis("Move_left", "Move_right"))
	
	if move_input:
		animated_sprite.flip_h = move_input < 0
	velocity.x = move_input * WALK_VELOCITY
	
	#if Input.is_action_just_pressed("Attack"):
		#var attack_name = "Attack1" if randi() % 2 == 0 else "Attack2"
		#animated_sprite.play(attack_name)
		#attack()
		#attacking = true
		#
	#
	#if Input.is_action_just_pressed("dash"):
		#dash.start_dash(dash_length)
	#
	#if Input.is_action_just_pressed("Jump") and is_on_floor() and not attacking:
		#velocity.y = JUMP_VELOCITY
#
	#if Input.is_action_just_released("Jump") and velocity.y < 0:
		#velocity.y *= 0.5

	#_update_animations(move_input)
 
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

func change_state(state: STATE):
	active_state = state
	match active_state:
		STATE.FALL:
			animated_sprite.play("Fall")
func process_state(delta):
	match active_state:
		STATE.FALL:
			velocity.y = move_toward(velocity.y, FALL_VELOCITY, FALL_GRAVITY * delta)
			move_logic()
		
		STATE.FLOOR:
			pass
		
		STATE.JUMP:
			pass
			
		STATE.DOUBLE_JUMP:
			pass
			
		STATE.FLOAT:
			pass
			
		STATE.LEDGE_CLIMB:
			pass
			
		STATE.LEDGE_JUMP:
			pass
