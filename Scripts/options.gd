extends Control

var volume:int = AudioServer.get_bus_volume_db(0)
@onready var volume_scroll_bar: HScrollBar = $VBoxContainer/HScrollBar


func _ready() -> void:
	volume_scroll_bar.value = volume + 80


func _on_h_scroll_bar_value_changed(value: float) -> void:
	volume = value
	AudioServer.set_bus_volume_db(0,volume-80)



func _on_mute_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_volume_db(0,-80)
	else:
		AudioServer.set_bus_volume_db(0,volume-80)
		

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1600,900))
		1:
			DisplayServer.window_set_size(Vector2i(1080,720))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))


func _on_mode_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
