extends Control



func _ready() -> void:
	visible = false
	get_tree().paused = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		visible = not visible
		get_tree().paused = not get_tree().paused

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit(0)


func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false
