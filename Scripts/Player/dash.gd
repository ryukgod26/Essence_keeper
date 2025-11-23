extends Node2D

@onready var dash_timer: Timer = $DashTimer
@onready var cooldown_timer: Timer = $Cooldown

func start_dash(dur):
	dash_timer.wait_time = dur
	dash_timer.start()
	
func is_dashing() -> bool:
	return not dash_timer.is_stopped() and not cooldown_timer.time_left


func _on_dash_timer_timeout() -> void:
	cooldown_timer.start()
