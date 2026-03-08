extends Node2D

class_name GameManager

@onready var worker = $Worker
@export var cell_size = Vector2i(32, 32)
@onready var placeholder_tilemap_layer = $PlaceholderTilemapLayer

var astar_grid = AStarGrid2D.new()
var grid_size

func _ready():
	InputManager.selected_units.append(worker)
	initialize_grid()

func _unhandled_input(event):
	InputManager.handle_inputs(event)

func initialize_grid():
	@warning_ignore("integer_division")
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	@warning_ignore("integer_division")
	astar_grid.offset = cell_size / 2
	
	for cell in placeholder_tilemap_layer.get_used_cells():
		var tile_data = placeholder_tilemap_layer.get_cell_tile_data(cell)
		if tile_data and tile_data.get_collision_polygons_count(0) > 0:
			astar_grid.set_point_solid(cell)
	
	astar_grid.update()
