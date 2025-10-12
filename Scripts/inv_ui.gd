extends Control

@onready var inv:Inv = preload("res://inventory/inverntory1.tres")
@onready var slots: Array 

var is_open:bool = false

func _ready():
	close()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if is_open:
			close()
		else:
			open()
		
				
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
