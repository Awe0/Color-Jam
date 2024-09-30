extends Label

signal Restart_Pressed
signal Menu_Pressed

func _on_restart_pressed() -> void:
	Restart_Pressed.emit()

func _on_menu_pressed() -> void:
	Menu_Pressed.emit()
