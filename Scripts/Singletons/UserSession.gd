extends Node

var is_login = false
@onready var session_config = ConfigFile.new()

func log_in_log_out():
	if is_login == false:
		is_login = true
	else:
		is_login = false

func save_session(user_id: int, user_name: String):
	session_config.set_value("user", "user_id", user_id)
	session_config.set_value("user", "user_name", user_name)
	session_config.save("user://session.cfg")

func check_session():
	var session_user_id = session_config.get_value("user","user_id")
	var session_user_name = session_config.get_value("user","user_name")
	var query = SqlController.get_user_from_db(session_user_name)
	if session_user_id == query["id"]:
		if session_user_name == ["name"]:
			is_login = true
