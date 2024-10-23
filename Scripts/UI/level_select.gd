extends Control

@onready var level_1: TextureButton = $"LevelContainer/Level 1"
@onready var level_2: TextureButton = $"LevelContainer/Level 2"
@onready var level_3: TextureButton = $"LevelContainer/Level 3"
@onready var level_4: TextureButton = $"LevelContainer/Level 4"
@onready var level_5: TextureButton = $"LevelContainer/Level 5"
@onready var level_6: TextureButton = $"LevelContainer/Level 6"
@onready var level_7: TextureButton = $"LevelContainer/Level 7"
@onready var level_8: TextureButton = $"LevelContainer/Level 8"
@onready var level_9: TextureButton = $"LevelContainer/Level 9"
@onready var level_10: TextureButton = $"LevelContainer/Level 10"
@onready var level_11: TextureButton = $"LevelContainer/Level 11"
@onready var level_12: TextureButton = $"LevelContainer/Level 12"
@onready var level_13: TextureButton = $"LevelContainer/Level 13"
@onready var level_14: TextureButton = $"LevelContainer/Level 14"
@onready var level_15: TextureButton = $"LevelContainer/Level 15"
@onready var level_16: TextureButton = $"LevelContainer/Level 16"

var scene_ui = preload("res://Scenes/Game/UI/Game_UI.tscn")

const LEVEL_INSTANCES: Dictionary = {
	"level 1" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 2" : preload("res://Scenes/Game/Levels/Level_2.tscn"),
	"level 3" : preload("res://Scenes/Game/Levels/Level_3.tscn"),
	"level 4" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 5" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 6" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 7" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 8" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 9" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 10" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 11" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 12" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 13" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 14" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 15" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level 16" : preload("res://Scenes/Game/Levels/Level_1.tscn")
}
const LEVELS: Array = [
	"level 1",
	"level 2",
	"level 3"
]

var level_buttons: Dictionary = {}

func _ready() -> void:
	level_buttons = {
		"level 1" : level_1,
		"level 2" : level_2,
		"level 3" : level_3,
		"level 4" : level_4,
		"level 5" : level_5,
		"level 6" : level_6,
		"level 7" : level_7,
		"level 8" : level_8,
		"level 9" : level_9,
		"level 10" : level_10,
		"level 11" : level_11,
		"level 12" : level_12,
		"level 13" : level_13,
		"level 14" : level_14,
		"level 15" : level_15,
		"level 16" : level_16
	}
	set_level_states()

func set_level_states():
	for level in LEVELS:
		if LevelStatement.level_state[level]:
			level_buttons[level].texture_normal = load("res://Assets/Buttons/Game_buttons/empty_100x100_button_pressed.png")

func _on_infinite_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Levels/Infinite_Mode.tscn")

func _on_level_1_pressed() -> void:
	var level_name = "level 1"
	var instance_game = LEVEL_INSTANCES[level_name].instantiate()
	create_game_level(instance_game, level_name)

func _on_level_2_pressed() -> void:
	var level_name = "level 2"
	var instance_game = LEVEL_INSTANCES[level_name].instantiate()
	create_game_level(instance_game, level_name)

func _on_level_3_pressed() -> void:
	var level_name = "level 3"
	var instance_game = LEVEL_INSTANCES[level_name].instantiate()
	create_game_level(instance_game, level_name)

func create_game_level(instance_game, level_name):
	var instance_ui = scene_ui.instantiate()
	instance_ui.add_child(instance_game)
	get_tree().root.add_child(instance_ui)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = instance_ui
	SignalBus.Level_is_selected.emit(level_name)
