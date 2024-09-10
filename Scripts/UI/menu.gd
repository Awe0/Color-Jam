extends Control

@onready var play: Label = $VBoxContainer/Play
@onready var login: Label = $VBoxContainer/Login

func _ready() -> void:
	#UserSession.check_session()
	display_buttons()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func display_buttons():
	if UserSession.is_login == true:
		play.visible = true
		login.visible = false
	else:
		play.visible = false
		login.visible = true
