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
@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var float_cooldown: Timer = $Timers/FloatCooldown
@onready var collision_shape: CollisionShape2D = %CollisionShape2D
@onready var ledge_space_ray_cast: RayCast2D = %LedgeSpaceRayCast
@onready var ledge_climb_raycast: RayCast2D = %LedgeClimbRaycast

@export var health := 5
@export var base_speed := 300.
@export var dash_speed := 800.
@export var dash_length := .1

const FALL_GRAVITY = 1500.
const FALL_VELOCITY = 500.
const WALK_VELOCITY = 300.
const JUMP_VELOCITY = -600.
const JUMP_DEACCELERATION = 1500.
const DOUBLE_JUMP_VELOCITY := -450.
const FLOAT_GRAVITY := 200.
const FLOAT_VELOCITY := 100.

var Enemies = []
signal health_changed(Health:int)
var SPEED:float = base_speed
var attacking
var active_state: STATE
var can_double_jump := false
var facing_direction := 1.0

#enum States {Idle,Walk,Run,Hurt,Death,TakeOff,Jump,Land,Fall}

#var anim_map :={
	#States.Idle:"Idle",
	#States.Walk: "Walk",
	#States.Run: "Run",
	#States.Hurt: "Hurt",
	#States.Death: "Death",
	#States.Jump:"Jump",
	#States.Fall: "Fall",
	#
#}

func _ready() -> void:
	change_state(STATE.FALL)
	ledge_climb_raycast.add_exception(self)

func _physics_process(delta: float) -> void:
	process_state(delta)
	handle_sprite_direction()
	move_and_slide()

func move_logic():
	var move_input := signf(Input.get_axis("Move_left", "Move_right"))
	
	if move_input:
		animated_sprite.flip_h = move_input < 0
		facing_direction = move_input
		ledge_climb_raycast.position.x = move_input * absf(ledge_climb_raycast.position.x)
		ledge_climb_raycast.target_position.x = move_input * absf(ledge_climb_raycast.target_position.x)
		ledge_climb_raycast.force_raycast_update()
		
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

func handle_sprite_direction() -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

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
	var previous_state := active_state
	active_state = state
	match active_state:
		STATE.FALL:
			if previous_state != STATE.DOUBLE_JUMP:
				animated_sprite.play("Fall")
			if previous_state == STATE.FLOOR:
				coyote_timer.start()
		
		STATE.FLOOR:
			can_double_jump = true
		
		STATE.JUMP:
			animated_sprite.play("Jump")
			velocity.y = JUMP_VELOCITY
			coyote_timer.stop()
		
		STATE.DOUBLE_JUMP:
			animated_sprite.play("DoubleJump")
			velocity.y = DOUBLE_JUMP_VELOCITY
			can_double_jump = false
		
		STATE.FLOAT:
			if float_cooldown.time_left > 0:
				active_state = previous_state
				return
			animated_sprite.play("Float")
			print("Create Float Animation")
			velocity.y = 0
		
		STATE.LEDGE_CLIMB:
			animated_sprite.play("LedgeClimb")
			velocity = Vector2.ZERO
			global_position.y = ledge_climb_raycast.get_collision_point().y
			can_double_jump = true

func process_state(delta):
	match active_state: 
		STATE.FALL:
			velocity.y = move_toward(velocity.y, FALL_VELOCITY, FALL_GRAVITY * delta)
			move_logic()
			
			if is_on_floor():
				change_state(STATE.FLOOR)
			elif Input.is_action_just_pressed("Jump")  :
				if coyote_timer.time_left> 0:
					change_state(STATE.JUMP)
				elif can_double_jump:
					change_state(STATE.DOUBLE_JUMP)
				else:
					change_state(STATE.FLOAT)
			
		STATE.FLOOR:
			if Input.get_axis("Move_left","Move_right"):
				animated_sprite.play("Walk")
			else:
				animated_sprite.play("Idle")
			move_logic()
			
			if not is_on_floor():
				change_state(STATE.FALL)
				
			if Input.is_action_just_pressed("Jump"):
				change_state(STATE.JUMP)
	
		
		STATE.JUMP, STATE.DOUBLE_JUMP:
			velocity.y = move_toward(velocity.y,0,JUMP_DEACCELERATION * delta)
			move_logic()
			if Input.is_action_just_released("Jump") or velocity.y >= 0:
				velocity.y = 0
				change_state(STATE.FALL)
			
		STATE.FLOAT:
			velocity.y = move_toward(velocity.y,FLOAT_VELOCITY,FLOAT_GRAVITY * delta)
			move_logic()
			
			if is_on_floor():
				change_state(STATE.FLOOR)
			elif Input.is_action_just_released("Jump"):
				float_cooldown.start()
				change_state(STATE.FALL)
			
		STATE.LEDGE_CLIMB:
			pass
			
		STATE.LEDGE_JUMP:
			pass

func is_input_toward_facing() -> bool:
	return signf(Input.get_axis("Move_left","Move_right")) == facing_direction

func is_ledge() -> bool:
	return is_on_wall_only() and ledge_climb_raycast.is_colliding() and ledge_climb_raycast.get_collision_normal().is_equal_approx(Vector2.UP)

func is_space() -> bool:
	ledge_space_ray_cast.global_position = ledge_climb_raycast.get_collision_point()
	ledge_space_ray_cast.force_raycast_update()
	return not ledge_space_ray_cast.is_colliding()

#func ledge_clim
