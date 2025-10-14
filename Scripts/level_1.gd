extends Node2D

var paused:bool= false

@onready var pause_menu: Control = $Fire_Player/PauseMenu


func _ready() -> void:
	Engine.time_scale = 1


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused


func _on_pause_menu_resumed() -> void:
	pauseMenu()
