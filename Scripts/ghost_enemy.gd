extends Area2D

var health = 4
const SPEED:int = 40
var player_chase:bool = false
var player = null
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var spawned:bool = false
var player_in_attack_zone= false

func _physics_process(delta: float) -> void:
	if not spawned:
		return
	if player_chase:
		position += (player.position - position)/SPEED
		
		if(player.position.x - position.x ) < 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
		if (player.position.y - position.y) > 0.1:
			position.y += 1
		animated_sprite.play("Idle")
	take_damage()
 
func enemy():
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		player_chase = true
		player = body
		animated_sprite.play("Spawn")
		

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		player_chase = false
		player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'Spawn':
		spawned = true


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		player_in_attack_zone = true


func take_damage():
	if player_in_attack_zone and Global.player_current_attack:
		health -= 2
		if health <= 0:
			self.queue_free()
