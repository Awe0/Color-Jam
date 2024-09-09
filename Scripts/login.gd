extends Control

signal create_user(username: String, password: String)

@onready var connection_username: TextEdit = $VBoxContainer/UsernameContainer/Label/MarginContainer/TextEdit
@onready var connection_password : LineEdit = $VBoxContainer/PasswordContainer/Label/MarginContainer/LineEdit
@onready var message_timer: Timer = $Messages/Timer
@onready var failed: Label = $Messages/Failed
@onready var succes: Label = $Messages/Succes

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_signin_button_pressed() -> void:
	if connection_username.text and connection_password.text:
		create_user.emit(connection_username.text,connection_password.text)

func _on_submit_button_pressed() -> void:
	if connection_username.text and connection_password.text:
		var data = {
			"name": connection_username.text,
			"password": connection_password.text,
		}
		SqlController.database.insert_row("userInfo",data)
		connection_username.text = ""
		connection_password.text = ""
		if failed.visible == true:
			failed.visible == false
		succes.visible = true
		message_timer.start(5)
		message_timer.timeout.connect(func() -> void:_on_timer_timeout())
	else:
		failed.visible = true
		message_timer.start(3)
		message_timer.timeout.connect(func() -> void:_on_timer_timeout())

func _on_timer_timeout() -> void:
	failed.visible = false
	succes.visible = false
