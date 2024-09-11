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
	copy_database_to_user()
	open_database()

func create_table():
	database.create_table("users",users_table)
	database.create_table("scores",scores_table)

func open_database():
	database = SQLite.new()
	database.path = "user://data.db"
	database.foreign_keys = true
	var db_result = database.open_db()
	if db_result:
		print("Database opened successfully")
	else:
		print("Failed to open the database")

func copy_database_to_user():
	var db_path = "res://data.db"
	var new_db_path = "user://data.db"
	if FileAccess.file_exists(new_db_path):
		print("Database already exists in user://")
		return 
	var file = FileAccess.open(db_path, FileAccess.ModeFlags.READ)
	if file:
		var data = file.get_buffer(file.get_length())
		file.close()
		var new_file = FileAccess.open(new_db_path, FileAccess.ModeFlags.WRITE)
		if new_file:
			new_file.store_buffer(data)
			new_file.close()
			print("Database copied successfully to user://")
		else:
			print("Error: Cannot write to user database path")
	else:
		print("Error: Cannot read from project database path")

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
	if database.query_result.size() > 0:
		var result = database.query_result[0]
		return {
			"id": result["id"],
			"score": result["score"],
			"user_id": result["user_id"]
		}
	return null
