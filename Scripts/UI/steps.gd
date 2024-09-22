extends Control

signal Quit_Pressed()
signal Back_Pressed()
signal Next_Pressed()

func _on_next_pressed() -> void:
	Next_Pressed.emit()

func _on_quit_pressed() -> void:
	Quit_Pressed.emit()

func _on_back_pressed() -> void:
	Back_Pressed.emit()
