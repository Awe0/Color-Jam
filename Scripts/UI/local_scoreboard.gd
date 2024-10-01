extends Control

@onready var rank_column: VBoxContainer = $HBoxContainer/rank_column
@onready var username_column: VBoxContainer = $HBoxContainer/username_column
@onready var score_column: VBoxContainer = $HBoxContainer/score_column

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_online_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Leaderboard/Leaderboard.tscn")
