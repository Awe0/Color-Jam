extends Control

signal create_user(username: String, password: String)

@onready var connection_username: TextEdit = $VBoxContainer/UsernameContainer/Label/MarginContainer/TextEdit
@onready var connection_password : LineEdit = $VBoxContainer/PasswordContainer/Label/MarginContainer/LineEdit

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_signin_button_pressed() -> void:
	create_user.emit(connection_username.text,connection_password.text)

func _on_submit_button_pressed() -> void:
	var data = {
		"name": connection_username.text,
		"password": connection_password.text,
	}
	SqlController.database.insert_row("userInfo",data)
	connection_username.text = ""
	connection_password.text = ""
