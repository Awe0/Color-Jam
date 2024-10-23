extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var score_label: Label = $HeadApp/Score
@onready var preview: TextureRect = $PreviewZone/Preview
@onready var preview_2: TextureRect = $PreviewZone/Preview2
@onready var preview_3: TextureRect = $PreviewZone/Preview3
@onready var restart_button: TextureButton = $VBoxContainer/Restart
@onready var delete_button: TextureButton = $VBoxContainer/Delete
@onready var param_button: TextureButton = $HeadApp/ParamButton
@onready var game_over: Label = $GameOver
@onready var rotate_button: TextureButton = $VBoxContainer2/Label/MarginContainer/Rotate
@onready var reroll_button: TextureButton = $VBoxContainer/Reroll
@onready var help: Control = $Help
@onready var level_label: Label = $Level
@onready var options: Control = $Options
@onready var amount_of_delete: Label = $AmountOf/TextureAmountOfDelete/AmountOfDelete
@onready var amount_of_reroll: Label = $AmountOf/TextureAmountOfReroll/AmountOfReroll

const MODE_NAME: String = "Infinite_mode"
const GRID_SIZE: int = 10
const BLANK_CELL = preload("res://Assets/Cells/cell54x54.png")
const GRAY_CELL = preload("res://Assets/Cells/gray.png")
const GRID_THEME_BUTTON = preload("res://Themes/BLANK_GRID.theme")

var option_scene = preload("res://Scenes/Game/UI/Options.tscn")
var help_scene = preload("res://Scenes/Help/Help.tscn")
var score: int = 0
var level: int = 1
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
	SignalBus.Restart_game.connect(on_restart_pressed)
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
	var previous_selected_scene = piece_queue[0] if piece_queue.size() > 0 else null
	for i in range(3):
		var new_piece = null
		while new_piece == null or new_piece == previous_selected_scene: # Compare les PackedScenes
			var random_index = randi() % color_scenes.size()
			new_piece = color_scenes[random_index]
		piece_queue[i] = new_piece
	selected_color = piece_queue[0].instantiate()
	update_previews()

func create_grid():
	for i in range(GRID_SIZE):
		var row = []
		for j in range(GRID_SIZE):
			var cell_button = Button.new()
			cell_button.set_theme(GRID_THEME_BUTTON)
			cell_button.icon = BLANK_CELL
			cell_button.flat = true
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
			cells[x][y].icon = load("res://Assets/Colors/"+ selected_color.color_name +".png")
			cells[x][y].flat = true
		preview.rotation = 0
		AudioPlayer.play_random_bubble_FX()
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
	score_label.text = str(score)
	SignalBus.Score_changed.emit(selected_color.score)

func reset_grid():
	for row in cells:
		for cell in row:
			if cell.icon != BLANK_CELL:
				cell.icon = BLANK_CELL

func upgrade_grid():
	level += 1
	SignalBus.Level_up.emit(level)
	level_label.text = "Level " + str(level)
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
			rotating_preview()
		else:
			selected_color.is_vertical = true
			rotating_preview()

func rotating_preview():
	if preview.rotation == 0:
		preview.rotation = -1.57079994678497
	elif preview.rotation != 0:
		preview.rotation = 0

func on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func update_rerolls():
	amount_of_reroll.text = str(reroll)
	if reroll <= 0:
		reroll_button.disabled
		if delete <= 0:
			game_over_statement()

func _on_change_piece_pressed() -> void:
	reroll -= 1
	if reroll >= 0:
		reroll_piece()
		update_rerolls()
	elif reroll <= 0:
		reroll = 0

func hide_interface():
	reroll_button.visible = false
	rotate_button.visible = false
	delete_button.visible = false
	amount_of_reroll.visible = false
	amount_of_delete.visible = false

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_delete_pressed() -> void:
	delete -= 1
	if delete >= 0:
		update_piece_queue()
		update_delete()
	elif delete <= 0:
		delete = 0

func update_delete():
	amount_of_delete.text = str(delete)
	if delete <= 0:
		delete_button.disabled
		if reroll <= 0:
			game_over_statement()

func game_over_statement():
	if not check_grid(selected_color):
		if reroll <= 0 && delete <= 0:
			game_over.visible = true
			SignalBus.Game_is_over.emit(score)
			LeaderboardsClient.submit_score(Leaderboards.LEADERBOARDS_ID[MODE_NAME], score)
			hide_interface()

func _on_help_quit_pressed() -> void:
	help.visible = false

func _on_param_button_pressed() -> void:
	var instance_option_scene = option_scene.instantiate()
	get_tree().root.add_child(instance_option_scene)
