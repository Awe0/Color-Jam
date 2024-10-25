extends Control

@onready var restart_button: TextureButton = $VBoxContainer/Restart
@onready var delete_button: TextureButton = $VBoxContainer/Delete
@onready var param_button: TextureButton = $HeadApp/ParamButton
@onready var stock_button: TextureButton = $VBoxContainer/Stock
@onready var game_over: Label = $GameOver
@onready var game_win: Label = $GameWin
@onready var rotate_button: TextureButton = $VBoxContainer2/Label/MarginContainer/Rotate
@onready var reroll_button: TextureButton = $VBoxContainer/Reroll
@onready var help: Control = $Help
@onready var options: Control = $Options
@onready var amount_of_reroll: Label = $AmountOf/TextureAmountOfReroll/AmountOfReroll
@onready var amount_of_delete: Label = $AmountOf/TextureAmountOfDelete/AmountOfDelete
@onready var label_level_name: Label = $Level
@onready var attempt_label: Label = $Label


var level_name_without_underscore: Dictionary = {
	"level_1" : "level 1",
	"level_2" : "level 2",
	"level_3" : "level 3",
	"level_4" : "level 4",
	"level_5" : "level 5",
	"level_6" : "level 6",
	"level_7" : "level 7",
	"level_8" : "level 8",
	"level_9" : "level 9",
	"level_10" : "level 10",
	"level_11" : "level 11",
	"level_12" : "level 12",
	"level_13" : "level 13",
	"level_14" : "level 14",
	"level_15" : "level 15",
	"level_16" : "level 16",
}

var level_name = null
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
	attempt_label.text = "ATTEMPT = " + str(attempt)

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
	stock_button.visible = false
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
		instanciate_scenes(PreloadScenes.game_over_scene)
		hide_interface()

func _on_param_button_pressed() -> void:
	instanciate_scenes(PreloadScenes.option_scene)

func game_win_statement():
	instanciate_scenes(PreloadScenes.game_win_scene)
	SaveSystem.save_levels_data(level_name, "state", true)
	if attempt < LevelStatement.level_state[level_name]["attempt"]:
		SaveSystem.save_levels_data(level_name, "attempt", attempt)
	SignalBus.Level_state_change.emit()
	LeaderboardsClient.submit_score(Leaderboards.LEADERBOARDS_ID[level_name], attempt)

func change_level_name(actual_level_name: String):
	label_level_name.text = level_name_without_underscore[actual_level_name]
	level_name = actual_level_name
	get_tree().current_scene.name = actual_level_name

func instanciate_scenes(scene):
	var scene_instance = scene.instantiate()
	get_tree().root.add_child(scene_instance)

func _on_stock_pressed() -> void:
	SignalBus.Stocking.emit()
