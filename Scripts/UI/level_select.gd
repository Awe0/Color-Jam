extends Control

@onready var level_container: GridContainer = $LevelContainer

const LEVEL_INSTANCES: Dictionary = {
	"level 1" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 2" : preload("res://Scenes/Game/Levels/Level_2.tscn"),
	"level 3" : preload("res://Scenes/Game/Levels/Level_3.tscn"),
	"level 4" : preload("res://Scenes/Game/Levels/Level_4.tscn"),
	"level 5" : preload("res://Scenes/Game/Levels/Level_5.tscn"),
	"level 6" : preload("res://Scenes/Game/Levels/Level_6.tscn"),
	"level 7" : preload("res://Scenes/Game/Levels/Level_7.tscn"),
	"level 8" : preload("res://Scenes/Game/Levels/Level_8.tscn"),
	"level 9" : preload("res://Scenes/Game/Levels/Level_9.tscn"),
	"level 10" : preload("res://Scenes/Game/Levels/Level_10.tscn"),
	"level 11" : preload("res://Scenes/Game/Levels/Level_11.tscn"),
	"level 12" : preload("res://Scenes/Game/Levels/Level_12.tscn"),
	"level 13" : preload("res://Scenes/Game/Levels/Level_13.tscn"),
	"level 14" : preload("res://Scenes/Game/Levels/Level_14.tscn"),
	"level 15" : preload("res://Scenes/Game/Levels/Level_15.tscn"),
	"level 16" : preload("res://Scenes/Game/Levels/Level_16.tscn")
}
const LEVELS: Array = [
	"level 1",
	"level 2",
	"level 3",
	"level 4",
	"level 5",
	"level 6",
	"level 7",
	"level 8",
	"level 9",
	"level 10",
	"level 11",
	"level 12",
	"level 13",
	"level 14",
	"level 15",
	"level 16",
]
const BUTTON_NORMAL_TEXTURE = preload("res://Assets/Buttons/Game_buttons/empty_100x100_button_normal.png")
const BUTTON_PRESSED_TEXTURE = preload("res://Assets/Buttons/Game_buttons/empty_100x100_button_pressed.png")

var scene_ui = preload("res://Scenes/Game/UI/Game_UI.tscn")
var level_buttons: Dictionary = {}

func _ready() -> void:
	create_level_button()
	set_level_states()

func set_level_states():
	for level in LEVELS:
		if LevelStatement.level_state[level]:
			level_buttons[level].texture_normal = load("res://Assets/Buttons/Game_buttons/empty_100x100_button_pressed.png")

func create_level_button():
	for level in LEVELS:
		var button = TextureButton.new()
		button.texture_normal = BUTTON_NORMAL_TEXTURE
		button.texture_pressed = BUTTON_PRESSED_TEXTURE
		button.pressed.connect(func() -> void:
			create_instance(level)
		)
		level_buttons[level] = button
		level_container.add_child(button)

func create_instance(level):
	var instance_game = LEVEL_INSTANCES[level].instantiate()
	create_game_level(instance_game, level)

func _on_infinite_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Levels/Infinite_Mode.tscn")

func create_game_level(instance_game, level_name):
	var instance_ui = scene_ui.instantiate()
	instance_ui.add_child(instance_game)
	get_tree().root.add_child(instance_ui)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = instance_ui
	SignalBus.Level_is_selected.emit(level_name)
