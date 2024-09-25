extends Control

@onready var play_button: TextureButton = $VBoxContainer2/play_button
@onready var scoreboard_button: Button = $VBoxContainer2/scoreboard_button
@onready var quit_button: Button = $VBoxContainer2/quit_button

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_scoreboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Leaderboard/Leaderboard.tscn")
