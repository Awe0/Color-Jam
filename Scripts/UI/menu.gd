extends Control

@onready var menu: Control = $"."
@onready var play_button: TextureButton = $ButtonContainer/play_button
@onready var scoreboard_button: TextureButton = $ButtonContainer/scoreboard_button
@onready var quit_button: TextureButton = $ButtonContainer/quit_button
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("default")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Level_Select.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_scoreboard_button_pressed() -> void:
	LeaderboardsClient.show_all_leaderboards()

func _on_achievement_button_pressed() -> void:
	AchievementsClient.show_achievements()
