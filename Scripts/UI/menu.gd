extends Control

@onready var play: Label = $VBoxContainer/Play
@onready var login: Label = $VBoxContainer/Login
@onready var scoreboard: Label = $VBoxContainer/Scoreboard

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func _on_scoreboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
