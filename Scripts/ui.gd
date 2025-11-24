extends CanvasLayer

@onready var health_bar: ProgressBar = $health_bar

func _ready() -> void:
	health_bar.value = 100

func change_health(val:int):
	health_bar.value = val


func _on_fire_player_health_changed(HEALTH: int) -> void:
	health_bar.value = HEALTH
