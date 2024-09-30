extends Control

@onready var menu: Control = $"."
@onready var play_button: TextureButton = $ButtonContainer/play_button
@onready var scoreboard_button: Button = $ButtonContainer/scoreboard_button
@onready var quit_button: Button = $ButtonContainer/quit_button


func _ready() -> void:
	pass

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_scoreboard_button_pressed() -> void:
	LeaderboardsClient.show_all_leaderboards()
