extends Node

var database: SQLite
var users_table = {
	"id" : {"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
	"name": {"data_type": "text"},
	"password": {"data_type": "text"},
}

var scores_table = {
	"id" : {"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
	"score" : {"data_type": "int"},
	"user_id" : {"data_type": "int", "foreign_key": "users.id"}
}

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.foreign_keys = true
	database.open_db()
	database.create_table("users",users_table)
	database.create_table("scores",scores_table)

func get_user_from_db(username: String):
	var query = database.query("SELECT * FROM users WHERE name = '"+username+"'")
	if database.query_result.size() > 0:
		var result = database.query_result[0]
		return {
			"id": result["id"],
			"name": result["name"],
			"password": result["password"]
		}
	return null

func get_scores_from_db(user_id: int):
	var query = database.query("SELECT * FROM scores WHERE user_id = '"+str(user_id)+"'")
	
