extends Label

signal Menu_Pressed

func _on_restart_pressed() -> void:
	SignalBus.Restart_Game.emit()

func _on_menu_pressed() -> void:
	Menu_Pressed.emit()
