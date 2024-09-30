extends Control

@onready var menu: Control = $"."
@onready var play_button: TextureButton = $ButtonContainer/play_button
@onready var scoreboard_button: Button = $ButtonContainer/scoreboard_button
@onready var quit_button: Button = $ButtonContainer/quit_button

var _leaderboards_cache: Array[LeaderboardsClient.Leaderboard] = []
var _leaderboard_display := preload("res://Scenes/Leaderboard/Local_Scoreboard.tscn")

func _ready() -> void:
	if _leaderboards_cache.is_empty():
		LeaderboardsClient.load_all_leaderboards(true)
	LeaderboardsClient.all_leaderboards_loaded.connect(
		func cache_and_display(leaderboards: Array[LeaderboardsClient.Leaderboard]):
			_leaderboards_cache = leaderboards
			if not _leaderboards_cache.is_empty():
				for leaderboard: LeaderboardsClient.Leaderboard in _leaderboards_cache:
					var container := _leaderboard_display.instantiate() as Control
					container.leaderboard = leaderboard
					menu.add_child(container)
	)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_scoreboard_button_pressed() -> void:
	LeaderboardsClient.show_all_leaderboards()
	#get_tree().change_scene_to_file("res://Scenes/Leaderboard/Local_Scoreboard.tscn")
