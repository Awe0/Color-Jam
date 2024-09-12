extends Control

@onready var score_container: HBoxContainer = $VBoxContainer/HBoxContainer

var score: int
var username: String

func _ready():
	add_score_on_board()

func add_score_on_board():
	#var query = SqlController.get_scores_from_db(UserSession.session_config.get_value("user","user_id"))
	var query = SqlController.get_scores_from_db()
	var label = Label.new()
	label.text = str(query)
	score_container.add_child(label)
	#print(SqlController.database.query_result)

#func test():
	#for row in SqlController.database.query_result:
		#var label = Label.new()
		#label.text = "User: " + str(row[0]) + " - Score: " + str(row[1])  # Utilise les indices selon la structure des résultats
		#score_container.add_child(label)

#func store_score():
	#var data = {
		#"score": score,
		#"username": username,
	#}
	#SqlController.database.insert_row("scores",data)
	#add_score_on_board()
