extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var score_label: Label = $Score
@onready var preview: CenterContainer = $Preview
@onready var restart_button: Button = $Restart
@onready var change_piece_button: Button = $ChangePiece
@onready var game_over: Label = $GameOver
@onready var rotate_button: Button = $Rotate

const GRID_SIZE = 10
const BLANK_CELL = preload("res://Assets/cell54x54.png")
const GRAY_CELL = preload("res://Assets/gray.png")
const GRID_THEME_BUTTON = preload("res://Themes/GridButton.theme")

var score: int = 0
var cells = []
var selected_color = null 
var attempt = 2
var color_scenes = [
	preload("res://Scenes/Colors/Yellow.tscn"),
	preload("res://Scenes/Colors/Green.tscn"),
	preload("res://Scenes/Colors/Brown.tscn"),
	preload("res://Scenes/Colors/Blue.tscn"),
	preload("res://Scenes/Colors/Red.tscn")
]
var color_previews = {
	"yellow": preload("res://Scenes/Colors/Previews/Yellow_Preview.tscn"),
	"green": preload("res://Scenes/Colors/Previews/Green_Preview.tscn"),
	"brown": preload("res://Scenes/Colors/Previews/Brown_Preview.tscn"),
	"blue": preload("res://Scenes/Colors/Previews/Blue_Preview.tscn"),
	"red": preload("res://Scenes/Colors/Previews/Red_Preview.tscn")
}

func _ready():
	create_grid()
	assign_random_color()

func create_grid():
	for i in range(GRID_SIZE):
		var row = []
		for j in range(GRID_SIZE):
			var cell_button = Button.new()
			cell_button.set_theme(GRID_THEME_BUTTON)
			cell_button.icon = BLANK_CELL
			cell_button.pressed.connect(func() -> void:
				_button_pressed(i, j)
			)
			grid_container.add_child(cell_button)
			row.append(cell_button)
		cells.append(row)

func _button_pressed(i: int, j: int) -> void:
	if selected_color:
		place_color(i, j)
		if not check_grid(selected_color):
			game_over.visible = true
			hide_all_buttons()
	else:
		return

func place_color(i: int, j: int):
	if can_place_color(i, j, selected_color.size, selected_color.is_vertical):
		selected_color.start_position = Vector2(i, j)
		for n in range(selected_color.size):
			var x = i + n if selected_color.is_vertical else i
			var y = j if selected_color.is_vertical else j + n
			cells[x][y].icon = load("res://Assets/"+ selected_color.color_name +".png")
		score_count()
		assign_random_color()
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

func assign_random_color():
	preview.rotation = 0
	var random_index = randi() % color_scenes.size()
	selected_color = color_scenes[random_index].instantiate()
	var color_name = selected_color.color_name
	if color_previews.has(color_name):
		var preview_instance = color_previews[color_name].instantiate()
		if preview.get_child_count() > 0:
			var last_preview = preview.get_child(0)
			last_preview.queue_free()
		preview.add_child(preview_instance)
		preview.scale = Vector2(0.8,0.8)

func check_grid(piece) -> bool:
	var has_blank_cell = false
	for row in cells:
		for cell in row:
			if cell.icon == BLANK_CELL:
				has_blank_cell = true
				break
	if not has_blank_cell:
		upgrade_grid()
	for i in range(GRID_SIZE):
		for j in range(GRID_SIZE):
			if can_place_color(i, j, piece.size, true):
				return true
			if can_place_color(i, j, piece.size, false):
				return true
	return false

func score_count():
	score += selected_color.score
	score_label.text = "Score: " + str(score)

func reset_grid():
	for row in cells:
		for cell in row:
			if cell.icon != BLANK_CELL:
				cell.icon = BLANK_CELL

func upgrade_grid():
	var probability_of_impossible = 0.2
	for row in cells:
		for cell in row:
			if randf() < probability_of_impossible:
				cell.icon = GRAY_CELL
			else:
				cell.icon = BLANK_CELL

func _on_rotate_pressed() -> void:
	if selected_color != null:
		if selected_color.is_vertical == true:
			selected_color.is_vertical = false
			SignalBus.rotate.emit()
		else:
			selected_color.is_vertical = true
			SignalBus.rotate.emit()

func _on_restart_pressed() -> void:
	game_over.visible = false
	display_all_buttons()
	reset_grid()
	var enable_theme_button = load("res://Themes/Buttons.tres")
	score = 0
	score_label.text = "Score: 0"
	change_piece_button.text = "Change\nPiece 2x"
	attempt = 2
	change_piece_button.set_theme(enable_theme_button)

func _on_change_piece_pressed() -> void:
	var disable_theme_button = load("res://Themes/Disable_Button.theme")
	if attempt == 2:
		assign_random_color()
		change_piece_button.text = "Change\nPiece 1x"
		attempt = 1
	elif attempt == 1:
		assign_random_color()
		change_piece_button.text = "No attempt!"
		attempt = 0
		change_piece_button.set_theme(disable_theme_button)
	else:
		pass

func _on_upgrade_pressed() -> void:
	upgrade_grid()

func hide_all_buttons():
	restart_button.visible = false
	change_piece_button.visible = false
	rotate_button.visible = false

func display_all_buttons():
	restart_button.visible = true
	change_piece_button.visible = true
	rotate_button.visible = true
