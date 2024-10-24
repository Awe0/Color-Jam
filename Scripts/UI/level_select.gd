extends Control

@onready var level_container: GridContainer = $LevelContainer
@onready var level_1: TextureRect = $level_1
@onready var level_2: TextureRect = $level_2
@onready var level_3: TextureRect = $level_3
@onready var level_4: TextureRect = $level_4
@onready var level_5: TextureRect = $level_5
@onready var level_6: TextureRect = $level_6
@onready var level_7: TextureRect = $level_7
@onready var level_8: TextureRect = $level_8
@onready var level_9: TextureRect = $level_9
@onready var level_10: TextureRect = $level_10
@onready var level_11: TextureRect = $level_11
@onready var level_12: TextureRect = $level_12
@onready var level_13: TextureRect = $level_13
@onready var level_14: TextureRect = $level_14
@onready var level_15: TextureRect = $level_15
@onready var level_16: TextureRect = $level_16



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
const LABEL_THEME = preload("res://Themes/Level_number.theme")
const GOLD_STAR = preload("res://Assets/Buttons/Level_select_buttons/Stars/gold_star_50x50.png")

var scene_ui = preload("res://Scenes/Game/UI/Game_UI.tscn")
var level_buttons: Dictionary = {}
var level_stars_texture: Dictionary = {}
func _ready() -> void:
	level_stars_texture = {
		"level_1" : level_1,
		"level_2" : level_2,
		"level_3" : level_3,
		"level_4" : level_4,
		"level_5" : level_5,
		"level_6" : level_6,
		"level_7" : level_7,
		"level_8" : level_8,
		"level_9" : level_9,
		"level_10" : level_10,
		"level_11" : level_11,
		"level_12" : level_12,
		"level_13" : level_13,
		"level_14" : level_14,
		"level_15" : level_15,
		"level_16" : level_16,
}
	create_level_button()
	set_level_states()

func set_level_states():
	for level in LEVELS:
		print(LevelStatement.level_state[level])
		if LevelStatement.level_state[level]:
			level_stars_texture[level].texture = GOLD_STAR

func create_level_button():
	for level in LEVELS:
		var button = TextureButton.new()
		button.texture_normal = load("res://Assets/Buttons/Level_select_buttons/"+level+"_button_normal.png")
		button.texture_pressed = load("res://Assets/Buttons/Level_select_buttons/"+level+"_button_pressed.png")
		button.pressed.connect(func() -> void:
			create_instance(level)
		)
		level_container.add_child(button)

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
