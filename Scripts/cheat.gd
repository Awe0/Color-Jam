extends Label

var score: int = 0
@onready var username_field: TextEdit = $Name



func _on_send_pressed() -> void:
	var username = username_field.text
	print(score)
	print(username)
	#await Leaderboards.post_guest_score("color-jam-color-jam-JJaQ",score,username)


func _on_score_1_pressed() -> void:
	score += 1
	print(score)


func _on_score_1000_pressed() -> void:
	score += 1000
	print(score)
