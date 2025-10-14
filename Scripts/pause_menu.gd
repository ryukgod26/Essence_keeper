extends Control

signal resumed

func _on_resume_pressed() -> void:
	resumed.emit()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit(0)
