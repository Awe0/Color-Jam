extends Control

@onready var restart_button: TextureButton = $VBoxContainer/Restart
@onready var delete_button: TextureButton = $VBoxContainer/Delete
@onready var param_button: TextureButton = $HeadApp/ParamButton
@onready var game_over: Label = $GameOver
@onready var game_win: Label = $GameWin
@onready var rotate_button: TextureButton = $VBoxContainer2/Label/MarginContainer/Rotate
@onready var reroll_button: TextureButton = $VBoxContainer/Reroll
@onready var help: Control = $Help
@onready var options: Control = $Options
@onready var amount_of_reroll: Label = $AmountOf/TextureAmountOfReroll/AmountOfReroll
@onready var amount_of_delete: Label = $AmountOf/TextureAmountOfDelete/AmountOfDelete
@onready var label_level_name: Label = $Level



var level_name = null
var game_win_scene = preload("res://Scenes/Game/UI/Game_Win.tscn")
var game_over_scene = preload("res://Scenes/Game/UI/Game_Over.tscn")
var option_scene = preload("res://Scenes/Game/UI/Options.tscn")
var help_scene = preload("res://Scenes/Help/Help.tscn")
var attempt: int = 0
var delete: int = 2
var reroll: int = 2


func _ready():
	SignalBus.Game_is_over.connect(game_over_statement)
	SignalBus.Level_is_selected.connect(change_level_name)
	SignalBus.Game_is_win.connect(game_win_statement)
	SignalBus.Attempt_increased.connect(increase_attempt)

func increase_attempt():
	attempt += 1

func _on_rotate_pressed() -> void:
	SignalBus.Rotating.emit()

func update_rerolls():
	amount_of_reroll.text = str(reroll)
	if reroll <= 0:
		reroll_button.disabled
		if delete <= 0:
			SignalBus.Check_Grid.emit()

func _on_reroll_pressed() -> void:
	reroll -= 1
	if reroll >= 0:
		SignalBus.Rerolling.emit()
		update_rerolls()
	elif reroll <= 0:
		reroll = 0

func hide_interface():
	reroll_button.visible = false
	rotate_button.visible = false
	delete_button.visible = false
	amount_of_reroll.visible = false
	amount_of_delete.visible = false
	$AmountOf/TextureAmountOfDelete.visible = false
	$AmountOf/TextureAmountOfReroll.visible = false

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_delete_pressed() -> void:
	delete -= 1
	if delete >= 0:
		SignalBus.Deleting.emit()
		update_delete()
	elif delete <= 0:
		delete = 0

func update_delete():
	amount_of_delete.text = str(delete)
	if delete <= 0:
		delete_button.disabled
		if reroll <= 0:
			SignalBus.Check_Grid.emit()

#Signal Game_Is_Over from Game.tscn
func game_over_statement():
	if reroll <= 0 && delete <= 0:
		instanciate_scenes(game_over_scene)
		hide_interface()

func _on_help_button_pressed() -> void:
	instanciate_scenes(help_scene)

func _on_param_button_pressed() -> void:
	instanciate_scenes(option_scene)

func game_win_statement():
	instanciate_scenes(game_win_scene)
	LevelStatement.level_state[level_name] = true
	SaveSystem.save_levels_data("levels_statement", level_name, true)
	LeaderboardsClient.submit_score(Leaderboards.LEADERBOARDS_ID[level_name], attempt)

func change_level_name(actual_level_name: String):
	label_level_name.text = actual_level_name
	level_name = actual_level_name
	get_tree().current_scene.name = actual_level_name

func instanciate_scenes(scene):
	var scene_instance = scene.instantiate()
	get_tree().root.add_child(scene_instance)
