extends Node

var is_login = false
var user_info = {
	"id" = null,
	"name" = "",
	"score" = 0
}

func set_user_info(id, name):
	user_info.id = id
	user_info.name = name

func log_in_log_out():
	if is_login == false:
		is_login = true
	else:
		is_login = false
