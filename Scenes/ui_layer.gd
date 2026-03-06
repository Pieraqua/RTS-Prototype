extends CanvasLayer

@onready var selection_rect = %SelectionRect

func _ready():
	InputManager.ui_layer = self
