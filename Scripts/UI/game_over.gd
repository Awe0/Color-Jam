extends Label

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Level_Select.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
