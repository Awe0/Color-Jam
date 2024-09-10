extends RefCounted

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
