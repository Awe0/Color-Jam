extends Control

signal Game_Is_Win

@onready var preview: TextureRect = $PreviewZone/Preview
@onready var preview_2: TextureRect = $PreviewZone/Preview2
@onready var preview_3: TextureRect = $PreviewZone/Preview3
@onready var grid_container: GridContainer = $GridContainer

const GRID_SIZE: int = 10
const BLANK_CELL = preload("res://Assets/Cells/cell54x54.png")
const GRAY_CELL = preload("res://Assets/Cells/gray.png")

var cells: Array = []
var selected_color = null 
var piece_queue: Array = []
var color_scenes = [
	preload("res://Scenes/Colors/Red.tscn"),
	preload("res://Scenes/Colors/Green.tscn"),
	preload("res://Scenes/Colors/Brown.tscn"),
	preload("res://Scenes/Colors/Blue.tscn"),
	preload("res://Scenes/Colors/Yellow.tscn"),
]
var color_previews = {
	"yellow": preload("res://Scenes/Colors/Previews/Yellow_Preview.tscn"),
	"green": preload("res://Scenes/Colors/Previews/Green_Preview.tscn"),
	"brown": preload("res://Scenes/Colors/Previews/Brown_Preview.tscn"),
	"blue": preload("res://Scenes/Colors/Previews/Blue_Preview.tscn"),
	"red": preload("res://Scenes/Colors/Previews/Red_Preview.tscn")
}

func _ready() -> void:
	SignalBus.Rotating.connect(rotate_selected_color)
	SignalBus.Rerolling.connect(reroll_piece)
	SignalBus.Deleting.connect(update_piece_queue)
	SignalBus.Check_Grid.connect(game_statement)
	get_cells_grid()
	initialize_piece_queue()
	update_previews()

func get_cells_grid():
	var all_buttons = grid_container.get_children()
	var button_index = 0
	for i in range(GRID_SIZE):
		var row = []
		for j in range(GRID_SIZE):
			var cell_button = all_buttons[button_index]
			button_index += 1
			cell_button.connect("pressed", func(i_copy := i, j_copy := j):
				place_on_grid(i_copy, j_copy)
			)
			row.append(cell_button)
		cells.append(row)

func place_on_grid(i: int, j: int) -> void:
	if selected_color:
		place_color(i, j)
		game_statement()
	else:
		return

func place_color(i: int, j: int):
	if can_place_color(i, j, selected_color.size, selected_color.is_vertical):
		selected_color.start_position = Vector2(i, j)
		for n in range(selected_color.size):
			var x = i + n if selected_color.is_vertical else i
			var y = j if selected_color.is_vertical else j + n
			cells[x][y].icon = load("res://Assets/Colors/"+ selected_color.color_name +".png")
			cells[x][y].flat = true
		#attempt += 1
		#preview.rotation = 0
		update_piece_queue()
		game_statement()
	else:
		return

func can_place_color(i: int, j: int, size: int, is_vertical: bool) -> bool:
	for n in range(size):
		var x = i + n if is_vertical else i
		var y = j if is_vertical else j + n
		if x >= GRID_SIZE or y >= GRID_SIZE or cells[x][y].text == "S":
			return false
		if cells[x][y].icon != BLANK_CELL:
			return false
	return true

func initialize_piece_queue():
	for i in range(3):
		var random_index = randi() % color_scenes.size()
		var new_piece = color_scenes[random_index]
		piece_queue.append(new_piece)
		selected_color = piece_queue[0].instantiate()

func update_piece_queue():
	piece_queue.pop_front()
	var random_index = randi() % color_scenes.size()
	var new_piece = color_scenes[random_index]
	piece_queue.append(new_piece)
	selected_color = piece_queue[0].instantiate()
	update_previews()

func check_grid(piece) -> bool:
	var has_blank_cell = false
	for row in cells:
		for cell in row:
			if cell.icon == BLANK_CELL:
				has_blank_cell = true
				break
	if not has_blank_cell:
		#Game_Is_Win.emit()
		pass
	for i in range(GRID_SIZE):
		for j in range(GRID_SIZE):
			if can_place_color(i, j, piece.size, true):
				return true
			if can_place_color(i, j, piece.size, false):
				return true
	return false

func reroll_piece():
	var previous_selected_scene = piece_queue[0] if piece_queue.size() > 0 else null
	for i in range(3):
		var new_piece = null
		while new_piece == null or new_piece == previous_selected_scene: # Compare les PackedScenes
			var random_index = randi() % color_scenes.size()
			new_piece = color_scenes[random_index]
		piece_queue[i] = new_piece
	selected_color = piece_queue[0].instantiate()
	update_previews()

func update_previews():
	# Met à jour la première pièce (celle sélectionnée actuellement)
	var color_name = selected_color.color_name
	if color_previews.has(color_name):
		var preview_instance = color_previews[color_name].instantiate()
		if preview.get_child_count() > 0:
			var last_preview = preview.get_child(0)
			last_preview.queue_free()
		preview.add_child(preview_instance)

	# Met à jour la deuxième pièce dans preview_2 (celle à venir)
	if piece_queue.size() > 1:
		var next_piece = piece_queue[1]
		color_name = next_piece.instantiate().color_name
		if color_previews.has(color_name):
			var preview_instance_2 = color_previews[color_name].instantiate()
			if preview_2.get_child_count() > 0:
				var last_preview_2 = preview_2.get_child(0)
				last_preview_2.queue_free()
			preview_2.add_child(preview_instance_2)

	# Met à jour la troisième pièce dans preview_3 (celle après la suivante)
	if piece_queue.size() > 2:
		var third_piece = piece_queue[2]
		color_name = third_piece.instantiate().color_name
		if color_previews.has(color_name):
			var preview_instance_3 = color_previews[color_name].instantiate()
			if preview_3.get_child_count() > 0:
				var last_preview_3 = preview_3.get_child(0)
				last_preview_3.queue_free()
			preview_3.add_child(preview_instance_3)

func rotate_selected_color():
	if selected_color != null:
		if selected_color.is_vertical == true:
			selected_color.is_vertical = false
			rotating_preview()
		else:
			selected_color.is_vertical = true
			rotating_preview()

func rotating_preview():
	if preview.rotation == 0:
		preview.rotation = -1.57079994678497
	elif preview.rotation != 0:
		preview.rotation = 0

func game_statement():
	if not check_grid(selected_color):
		SignalBus.Game_Is_Over.emit()
