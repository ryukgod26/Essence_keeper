extends Node2D

var paused:bool= false

@onready var pause_menu: Control = $Entities/fire_player/PauseMenu2


func _ready() -> void:
	Engine.time_scale = 1

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

func pauseMenu() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func _on_pause_menu_resumed() -> void:
	pauseMenu()
