class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash: Node2D = $Dash

@export var health := 5
@export var base_speed := 300.
@export var dash_speed := 800.
@export var dash_length := .1


var SPEED:float = base_speed
var attacking

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	move_logic(delta)


func move_logic(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	var move_input := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(dash_length)
	SPEED = dash_speed if dash.is_dashing() else base_speed
	if is_on_floor() and not attacking:
		if move_input != 0:
			velocity.x = move_input * SPEED
			animated_sprite.play("Run")
			animated_sprite.flip_h = move_input < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED + dash_speed)
			animated_sprite.play("Idle")
	
	
	move_and_slide()
