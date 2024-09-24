extends Control

@onready var play_button: Button = $VBoxContainer2/play_button
@onready var scoreboard_button: Button = $VBoxContainer2/scoreboard_button
@onready var quit_button: Button = $VBoxContainer2/quit_button

var _sign_in_retries := 5

#func _ready() -> void:
	#if not GodotPlayGameServices.android_plugin:
		#print("Plugin Not Found!")
	#
	#SignInClient.user_authenticated.connect(func(is_authenticated: bool):
		#if _sign_in_retries > 0 and not is_authenticated:
			#print("Trying to sign in!")
			#SignInClient.sign_in()
			#_sign_in_retries -= 1
		#
		#if _sign_in_retries == 0:
			#print("Sign in attemps expired!")
		#
		#if is_authenticated:
			#print("Main Menu")
	#)

func _on_play_button_pressed() -> void:
	play_button.icon = load("res://Assets/Menu_buttons/bouton_play_menu_off.png")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func _on_scoreboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
