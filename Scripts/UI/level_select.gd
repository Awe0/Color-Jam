extends Control

@onready var level_container: GridContainer = $LevelContainer
@onready var level_1: TextureRect = $"Level 1"
@onready var level_2: TextureRect = $"Level 2"
@onready var level_3: TextureRect = $"Level 3"
@onready var level_4: TextureRect = $"Level 4"
@onready var level_5: TextureRect = $"Level 5"
@onready var level_6: TextureRect = $"Level 6"
@onready var level_7: TextureRect = $"Level 7"
@onready var level_8: TextureRect = $"Level 8"
@onready var level_9: TextureRect = $"Level 9"
@onready var level_10: TextureRect = $"Level 10"
@onready var level_11: TextureRect = $"Level 11"
@onready var level_12: TextureRect = $"Level 12"
@onready var level_13: TextureRect = $"Level 13"
@onready var level_14: TextureRect = $"Level 14"
@onready var level_15: TextureRect = $"Level 15"
@onready var level_16: TextureRect = $"Level 16"

const LEVEL_INSTANCES: Dictionary = {
	"level_1" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level_2" : preload("res://Scenes/Game/Levels/Level_2.tscn"),
	"level_3" : preload("res://Scenes/Game/Levels/Level_3.tscn"),
	"level_4" : preload("res://Scenes/Game/Levels/Level_4.tscn"),
	"level_5" : preload("res://Scenes/Game/Levels/Level_5.tscn"),
	"level_6" : preload("res://Scenes/Game/Levels/Level_6.tscn"),
	"level_7" : preload("res://Scenes/Game/Levels/Level_7.tscn"),
	"level_8" : preload("res://Scenes/Game/Levels/Level_8.tscn"),
	"level_9" : preload("res://Scenes/Game/Levels/Level_9.tscn"),
	"level_10" : preload("res://Scenes/Game/Levels/Level_10.tscn"),
	"level_11" : preload("res://Scenes/Game/Levels/Level_11.tscn"),
	"level_12" : preload("res://Scenes/Game/Levels/Level_12.tscn"),
	"level_13" : preload("res://Scenes/Game/Levels/Level_13.tscn"),
	"level_14" : preload("res://Scenes/Game/Levels/Level_14.tscn"),
	"level_15" : preload("res://Scenes/Game/Levels/Level_15.tscn"),
	"level_16" : preload("res://Scenes/Game/Levels/Level_16.tscn")
}

const LEVELS: Array = [
	"level_1",
	"level_2",
	"level_3",
	"level_4",
	"level_5",
	"level_6",
	"level_7",
	"level_8",
	"level_9",
	"level_10",
	"level_11",
	"level_12",
	"level_13",
	"level_14",
	"level_15",
	"level_16",
]
const BUTTON_NORMAL_TEXTURE = preload("res://Assets/Buttons/Game_buttons/empty_100x100_button_normal.png")
const BUTTON_PRESSED_TEXTURE = preload("res://Assets/Buttons/Game_buttons/empty_100x100_button_pressed.png")
const LABEL_THEME = preload("res://Themes/Level_number.theme")
#const GOLD_STAR = preload("res://Assets/Buttons/Stars/gold_star.png")

var scene_ui = preload("res://Scenes/Game/UI/Game_UI.tscn")
var level_buttons: Dictionary = {}
var level_stars_texture: Dictionary = {}
func _ready() -> void:
	level_stars_texture = {
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
		"level 16" : level_16,
}
	create_level_button()
	#create_button_label()
	set_level_states()

func set_level_states():
	for level in LEVELS:
		if LevelStatement.level_state[level]:
			pass
			#level_stars_texture[level].texture = GOLD_STAR

func create_level_button():
	for level in LEVELS:
		var button = TextureButton.new()
		button.texture_normal = BUTTON_NORMAL_TEXTURE
		button.texture_pressed = BUTTON_PRESSED_TEXTURE
		button.pressed.connect(func() -> void:
			create_instance(level)
		)
		level_container.add_child(button)

#func create_button_label():
	#var level_number = 0
	#for level in LEVELS:
		#level_number += 1
		#var label = Label.new()
		#label.text = str(level_number)
		#label.set_theme(LABEL_THEME)

func create_instance(level):
	var instance_game = LEVEL_INSTANCES[level].instantiate()
	create_level(instance_game, level)

func _on_infinite_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Levels/Infinite_Mode.tscn")

func create_level(instance_game, level_name):
	var instance_ui = scene_ui.instantiate()
	instance_ui.add_child(instance_game)
	get_tree().root.add_child(instance_ui)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = instance_ui
	SignalBus.Level_is_selected.emit(level_name)
