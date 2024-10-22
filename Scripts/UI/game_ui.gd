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

const MODE_NAME: String = "Level_2"
const LEVEL = "level 2"

var option_scene = preload("res://Scenes/Game/UI/Options.tscn")
var help_scene = preload("res://Scenes/Help/Help.tscn")
var attempt: int = 0
var delete = 2
var reroll = 2


func _ready():
	SignalBus.Restart_Game.connect(on_restart_pressed)
	SignalBus.Game_is_over.connect(game_over_statement)
	SignalBus.Level_is_selected.connect(change_level_name)

func _on_rotate_pressed() -> void:
	SignalBus.Rotating.emit()

func on_restart_pressed() -> void:
	get_tree().reload_current_scene()

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
		game_over.visible = true
		hide_interface()

func _on_help_button_pressed() -> void:
	var instance_help_scene = help_scene.instantiate()
	get_tree().root.add_child(instance_help_scene)

func _on_help_quit_pressed() -> void:
	help.visible = false

func _on_param_button_pressed() -> void:
	var instance_option_scene = option_scene.instantiate()
	get_tree().root.add_child(instance_option_scene)

func game_win_statement():
	game_win.visible = true
	LevelStatement.level_state[LEVEL] = true
	SaveSystem.save_levels_data("levels_statement", LEVEL, true)
	LeaderboardsClient.submit_score(Leaderboards.LEADERBOARDS_ID[MODE_NAME], attempt)

func change_level_name(level_name: String):
	label_level_name.text = level_name
