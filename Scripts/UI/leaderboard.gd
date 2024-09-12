extends Control

@onready var menu_button: Button = $Menu



func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


func _on_local_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scoreboard.tscn")
