extends Control

@onready var score_container: HBoxContainer = $VBoxContainer/HBoxContainer
@onready var rank_column: VBoxContainer = $HBoxContainer/rank_column
@onready var username_column: VBoxContainer = $HBoxContainer/username_column
@onready var score_column: VBoxContainer = $HBoxContainer/score_column
@onready var all_datas: Array = SqlController.get_scores_from_db()

const LABEL_ON_SCOREBOARD = preload("res://Themes/label_on_scoreboard.theme")

var score: int
var username: String

func _ready():
	all_datas.sort_custom(compare_scores_desc)
	add_score_on_board()

func add_score_on_board():
	create_score_label()
	create_username_label()

func compare_scores_desc(a: Dictionary, b: Dictionary) -> bool:
	return a["score"] > b["score"]

func create_score_label():
	for score in all_datas:
		var label = Label.new()
		label.set_theme(LABEL_ON_SCOREBOARD)
		label.text = str(score["score"])
		label.horizontal_alignment = 1
		score_column.add_child(label)

func create_username_label():
	for score in all_datas:
		var label = Label.new()
		label.set_theme(LABEL_ON_SCOREBOARD)
		label.text = str(score["username"])
		label.horizontal_alignment = 1
		username_column.add_child(label)

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
