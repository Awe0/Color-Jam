extends Control

@onready var play_button: Button = $VBoxContainer2/play_button
@onready var scoreboard_button: Button = $VBoxContainer2/scoreboard_button
@onready var quit_button: Button = $VBoxContainer2/quit_button

func _on_play_button_pressed() -> void:
	play_button.icon = load("res://Assets/Menu_buttons/bouton_play_menu_off.png")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func _on_scoreboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
