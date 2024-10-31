extends Control

@onready var background: ColorRect = $Background
@onready var _3_stars: TextureRect = $"3Stars"
@onready var _2_stars: TextureRect = $"2Stars"
@onready var _1_star: TextureRect = $"1Star"
@onready var _0_star: TextureRect = $"0Star"

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

var actual_level_name: String

func _ready() -> void:
	get_actual_level_name()
	SignalBus.Level_completed.connect(check_attempt_for_stars_texture)

func check_attempt_for_stars_texture(level_name, attempt):
	var gold_threshold = LevelStatement.level_attempt[level_name][0]
	var silver_threshold = LevelStatement.level_attempt[level_name][1]
	var bronze_threshold = LevelStatement.level_attempt[level_name][2]

	if attempt < gold_threshold:
		_3_stars.visible = true
		background.visible = true
	elif attempt < silver_threshold:
		_2_stars.visible = true
		background.visible = true
	elif attempt < bronze_threshold:
		_1_star.visible = true
		background.visible = true
	else:
		_0_star.visible = true
		background.visible = true

func get_actual_level_name() -> void:
	for i in range(get_tree().root.get_child_count()):
		var child = get_tree().root.get_child(i)
		if LEVELS.find(child.name) != -1:
			actual_level_name = child.name
			print("Nom du niveau actuel :", actual_level_name)
			return
	print("Aucun niveau actuel trouvé")

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Level_Select.tscn")

func _on_next_button_pressed() -> void:
	var current_index = LEVELS.find(actual_level_name)
	var next_level = LEVELS[current_index + 1]
	create_instance(next_level)

func create_instance(level):
	var instance_game = PreloadScenes.LEVEL_INSTANCES[level].instantiate()
	create_level(instance_game, level)

func create_level(instance_game, level_name):
	var instance_ui = PreloadScenes.scene_ui.instantiate()
	instance_ui.add_child(instance_game)
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(instance_ui)
	get_tree().current_scene = instance_ui
	SignalBus.Level_is_selected.emit(level_name)
