extends Control

@onready var play: Label = $VBoxContainer/Play
@onready var login: Label = $VBoxContainer/Login
@onready var scoreboard: Label = $VBoxContainer/Scoreboard

func _ready() -> void:
	UserSession.check_session()
	display_buttons()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func _on_scoreboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scoreboard.tscn")

func display_buttons():
	if UserSession.is_login == true:
		play.visible = true
		scoreboard.visible = true
		login.visible = false
	else:
		play.visible = false
		scoreboard.visible = false
		login.visible = true
