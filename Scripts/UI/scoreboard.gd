extends Control

@onready var score_container: HBoxContainer = $VBoxContainer/HBoxContainer

func _ready():
	add_score_on_board()
	SignalBus.Game_is_over.connect(add_score_on_board)
	
func add_score_on_board():
	print("Signal 'Game_is_over' ok !")
	var query = SqlController.get_scores_from_db(UserSession.session_config.get_value("user","user_id"))
	var label = Label.new()
	label.text = str(query)
	score_container.add_child(label)
	#score_container.add_child()
