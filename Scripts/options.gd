extends Control

@onready var master_volume: HSlider = $TabContainer/Audio/MasterVolume
@onready var music_volume: HSlider = $TabContainer/Audio/MusicVolume
@onready var sfx_volume: HSlider = $TabContainer/Audio/SfxVolume

var master_volume_bus
var music_volume_bus
var sfx_volume_bus

func _ready() -> void:
	master_volume_bus = AudioServer.get_bus_index("Master")
	music_volume_bus = AudioServer.get_bus_index("Music")
	sfx_volume_bus = AudioServer.get_bus_index("SFX")
	
	master_volume.value = db_to_linear(AudioServer.get_bus_volume_db(master_volume_bus))
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(music_volume_bus))
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_volume_bus))
	
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_WINDOWED:
			$TabContainer/Video/Mode.select(0)
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			$TabContainer/Video/Mode.select(1)
		_:
			$TabContainer/Video/Mode.select(-1)
	
	match DisplayServer.window_get_size():
		Vector2i(1600,900):
			$TabContainer/Video/Resolution.select(0)
		Vector2i(1080,720):
			$TabContainer/Video/Resolution.select(1)
		Vector2i(1920,1080):
			$TabContainer/Video/Resolution.select(2)
		_:
			$TabContainer/Video/Resolution.select(-1)

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


func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_volume_bus,linear_to_db(value))
	AudioServer.set_bus_mute(master_volume_bus,value < 0.05)


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_volume_bus,linear_to_db(value))
	AudioServer.set_bus_mute(music_volume_bus,value < 0.05)


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_volume_bus,linear_to_db(value))
	AudioServer.set_bus_mute(sfx_volume_bus,value < 0.05)
