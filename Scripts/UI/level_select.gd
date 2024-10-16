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

const LEVELS : Array = [
	"level 1",
	"level 2",
]

var level_buttons : Dictionary = {}

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
	check_level_states()

func check_level_states():
	for level in LEVELS:
		if LevelStatement.level_state[level]:
			level_buttons[level].texture_normal = load("res://Assets/Buttons/Game_buttons/help_button_pressed.png")

func _on_infinite_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Infinite_Mode.tscn")

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Level_1.tscn")
