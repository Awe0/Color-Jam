extends Control

@onready var background: ColorRect = $Background
@onready var _3_stars: TextureRect = $"3Stars"
@onready var _2_stars: TextureRect = $"2Stars"
@onready var _1_star: TextureRect = $"1Star"
@onready var _0_star: TextureRect = $"0Star"


func _ready() -> void:
	SignalBus.Level_completed.connect(check_attempt_for_stars_texture)

func check_attempt_for_stars_texture(level_name, attempt):
	var gold_threshold = LevelStatement.level_attempt[level_name][0]
	var silver_threshold = LevelStatement.level_attempt[level_name][1]
	var bronze_threshold = LevelStatement.level_attempt[level_name][2]

	print(attempt)

	if attempt <= gold_threshold:
		_3_stars.visible = true
		background.visible = true
	elif attempt <= silver_threshold:
		_2_stars.visible = true
		background.visible = true
	elif attempt <= bronze_threshold:
		_1_star.visible = true
		background.visible = true
	else:
		_0_star.visible = true
		background.visible = true

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Level_Select.tscn")
