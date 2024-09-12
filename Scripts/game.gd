extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var score_label: Label = $Score
@onready var preview: CenterContainer = $HBoxContainer/Preview
@onready var preview_2: CenterContainer = $HBoxContainer/Preview2
@onready var preview_3: CenterContainer = $HBoxContainer/Preview3
@onready var restart_button: Button = $VBoxContainer/Label/MarginContainer/Restart
@onready var change_piece_button: Button = $VBoxContainer/Label2/MarginContainer/ChangePiece
@onready var delete_button: Button = $VBoxContainer/Label3/MarginContainer/Delete
@onready var game_over: Label = $GameOver
@onready var rotate_button: Button = $VBoxContainer2/Label/MarginContainer/Rotate

const GRID_SIZE = 10
const BLANK_CELL = preload("res://Assets/cell54x54.png")
const GRAY_CELL = preload("res://Assets/gray.png")
const GRID_THEME_BUTTON = preload("res://Themes/GridButton.theme")
const DISABLE_THEME_BUTTON = preload("res://Themes/Disable_Button.theme")
const ENABLE_THEME_BUTTON = preload("res://Themes/Buttons.tres")

var score: int = 0
var cells = []
var selected_color = null 
var piece_queue = []
var delete = 2
var reroll = 2
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

func _ready():
	SignalBus.Username_sended.connect(store_score)
	initialize_piece_queue()
	create_grid()
	update_previews()

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

func reroll_piece():
	var random_index = randi() % color_scenes.size()
	var new_piece = color_scenes[random_index]
	piece_queue[0] = new_piece
	selected_color = piece_queue[0].instantiate()
	update_previews()

func create_grid():
	for i in range(GRID_SIZE):
		var row = []
		for j in range(GRID_SIZE):
			var cell_button = Button.new()
			cell_button.set_theme(GRID_THEME_BUTTON)
			cell_button.icon = BLANK_CELL
			cell_button.pressed.connect(func() -> void:
				place_on_grid(i, j)
			)
			grid_container.add_child(cell_button)
			row.append(cell_button)
		cells.append(row)

func place_on_grid(i: int, j: int) -> void:
	if selected_color:
		place_color(i, j)
		game_over_statement()
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
		update_piece_queue()
		game_over_statement()
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
	reroll += 2
	delete += 2
	update_rerolls()
	update_delete()
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
			SignalBus.Rotate.emit()
		else:
			selected_color.is_vertical = true
			SignalBus.Rotate.emit()

func _on_restart_pressed() -> void:
	game_over.visible = false
	display_all_buttons()
	reset_grid()
	var enable_theme_button = load("res://Themes/Buttons.tres")
	score = 0
	score_label.text = "Score: 0"
	reroll = 2
	update_rerolls()
	delete = 2
	update_delete()
	change_piece_button.set_theme(enable_theme_button)

func update_rerolls():
		if reroll > 0:
			change_piece_button.set_theme(ENABLE_THEME_BUTTON)
			change_piece_button.text = "Reroll\nPiece "+str(reroll)+"x"
		elif reroll <= 0:
			change_piece_button.set_theme(DISABLE_THEME_BUTTON)
			change_piece_button.text = "No\nReroll!"
			if delete <= 0:
				game_over_statement()

func _on_change_piece_pressed() -> void:
	reroll -= 1
	if reroll >= 0:
		reroll_piece()
		update_rerolls()
	elif reroll <= 0:
		reroll = 0

func hide_all_buttons():
	restart_button.visible = false
	change_piece_button.visible = false
	rotate_button.visible = false
	delete_button.visible = false

func display_all_buttons():
	restart_button.visible = true
	change_piece_button.visible = true
	rotate_button.visible = true
	delete_button.visible = true

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_delete_pressed() -> void:
	delete -= 1
	if delete >= 0:
		update_piece_queue()
		update_delete()
	elif delete <= 0:
		delete = 0

func update_delete():
		if delete > 0:
			delete_button.set_theme(ENABLE_THEME_BUTTON)
			delete_button.text = "Delete\nPiece "+str(delete)+"x"
		elif delete <= 0:
			delete_button.set_theme(DISABLE_THEME_BUTTON)
			delete_button.text = "No\nDelete!"
			if reroll <= 0:
				game_over_statement()

func game_over_statement():
	if not check_grid(selected_color):
		if reroll <= 0 && delete <= 0:
			game_over.visible = true
			SignalBus.Game_is_over.emit(score)
			hide_all_buttons()

func store_score(username: String):
	var data = {
		"score": score,
		"username": username,
	}
	SqlController.database.insert_row("scores",data)
	await Leaderboards.post_guest_score("color-jam-color-jam-JJaQ",score,username)
