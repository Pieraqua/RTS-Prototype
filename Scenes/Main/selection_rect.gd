extends Node2D

var dragging = false
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_viewport().get_mouse_position() - drag_start),
			Color.YELLOW, false, 2.0)
