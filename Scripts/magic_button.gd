extends Control

@onready var button = $Button
@onready var anim = $AnimationPlayer
@onready var label = $ButtonText

# Export allows you to change text in the Inspector for each instance
@export var text: String = "Button":
	set(value):
		text = value
		if label: label.text = value

func _ready():
	# Connect the internal button signals
	button.mouse_entered.connect(_on_hover)
	button.mouse_exited.connect(_on_exit)
	button.pressed.connect(_on_pressed)
	label.text = text

func _on_hover():
	anim.play("hover_glow") # Create this animation to fade in the Glow node
	# Optional: Play a "Stone Grinding" sound effect here

func _on_exit():
	anim.play_backwards("hover_glow")

func _on_pressed():
	# Forward the signal to the parent menu
	# You can define a custom signal if you want
	pass
