extends Node

class_name Input_Manager

var selected_units : Array[Unit] = []
var dragging : bool = false
var ui_layer : CanvasLayer

func handle_inputs(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			var target = get_viewport().get_mouse_position()
			selected_units.map(func(x): x.walk_towards(target))
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			_start_dragging(event)
		elif dragging:
			_stop_dragging(event)
	elif event is InputEventMouseMotion and dragging:
		ui_layer.selection_rect.queue_redraw()

func _stop_dragging(event):
	dragging = false
	ui_layer.selection_rect.dragging = false
	ui_layer.selection_rect.queue_redraw()
	var drag_end = event.position
	ui_layer.selection_rect.select_rect.extents = abs(drag_end - ui_layer.selection_rect.drag_start) / 2
	var space = ui_layer.selection_rect.get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = ui_layer.selection_rect.select_rect
	query.collision_mask = 2
	query.transform = Transform2D(0, (drag_end + ui_layer.selection_rect.drag_start) / 2)
	space.intersect_shape(query).map(func(x): selected_units.append(x["collider"]))

func _start_dragging(event):
	dragging = true
	ui_layer.selection_rect.dragging = true
	selected_units = []
	ui_layer.selection_rect.drag_start = event.position
