extends CanvasLayer

@onready var health_bar: ProgressBar = $health_bar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fire_player_health_changed(HEALTH: int) -> void:
	health_bar.value = HEALTH
