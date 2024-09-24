extends Control

signal create_user(username: String, password: String)

@onready var connection_username: TextEdit = $VBoxContainer/UsernameContainer/Label/MarginContainer/TextEdit
@onready var connection_password : LineEdit = $VBoxContainer/PasswordContainer/Label/MarginContainer/LineEdit
@onready var message_timer: Timer = $Messages/Timer
@onready var failed: Label = $Messages/Failed
@onready var success: Label = $Messages/Success
@onready var no_account: Label = $"Messages/No account"

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

#func _on_signin_button_pressed() -> void:
	#var query = SqlController.get_user_from_db(connection_username.text)
	#if query != null:
		#if connection_username.text and connection_password.text:
			#if connection_password.text == query["password"]:
				#UserSession.log_in_log_out()
				#UserSession.save_session(query["id"], query["name"])
				#get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
			#else:
				#print("NEIN")
	#else:
		#display_label_and_start_timer(no_account)
#
#func _on_submit_button_pressed() -> void:
	#if connection_username.text and connection_password.text:
		#var data = {
			#"name": connection_username.text,
			#"password": connection_password.text,
		#}
		#SqlController.database.insert_row("users",data)
		#connection_username.text = ""
		#connection_password.text = ""
		#if failed.visible == true:
			#failed.visible == false
		#create_user.emit(connection_username.text,connection_password.text)
		#display_label_and_start_timer(success)
	#else:
		#display_label_and_start_timer(failed)

func _on_timer_timeout(label: Label) -> void:
	label.visible = false

func display_label_and_start_timer(label: Label):
	label.visible = true
	message_timer.start(5)
	message_timer.timeout.connect(func() -> void:_on_timer_timeout(label))
