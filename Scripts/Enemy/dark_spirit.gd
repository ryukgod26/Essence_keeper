extends Enemy


func _on_detection_area_body_entered(body: Node2D) -> void:
	print('Player')
	if body.is_in_group("Player"):
		print("Player Found")
		player = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
