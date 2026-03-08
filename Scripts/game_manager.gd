extends Node2D

class_name GameManager

@onready var worker = $Worker

func _ready():
	InputManager.selected_units.append(worker)

func _unhandled_input(event):
	InputManager.handle_inputs(event)
