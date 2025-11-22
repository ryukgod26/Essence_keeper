class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var health := 5
@export var base_speed := 50.
@export var dash_speed := 60.

var SPEED:float
var attacking

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	move_logic()
	dash()

func move_logic():
	var move_input := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")

	if is_on_floor() and not attacking:
		if move_input != 0:
			velocity.x = move_input * SPEED
			animated_sprite.play("Run")
			animated_sprite.flip_h = move_input < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("Idle")

func dash():
	var dash_input := Input.is_action_pressed("dash")
	if dash_input:
		var tween = create_tween()
		tween.tween_property(self,"SPEED",dash_speed,0.1).set_ease(Tween.EASE_OUT)
		
