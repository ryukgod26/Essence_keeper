extends Node2D



func _on_player_health_changed(Health: int) -> void:
	$UI.change_health(Health)
