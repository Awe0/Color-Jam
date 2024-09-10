extends Node

var database: SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	var table = {
		"id" : {"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name": {"data_type": "text"},
		"password": {"data_type": "text"},
	}
	database.create_table("userInfo",table)

func get_user_from_db(username: String):
	var query = database.query("SELECT * FROM userInfo WHERE name = '"+username+"'")
	if database.query_result.size() > 0:
		var result = database.query_result[0]
		return {
			"id": result["id"],
			"name": result["name"],
			"password": result["password"]
		}
	return null
