extends Control


func _on_infinite_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Infinite_Mode.tscn")

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/Level_1.tscn")