extends Label

signal Restart_Pressed
signal Menu_Pressed
signal Send_Pressed(username: String)

@onready var text_edit: TextEdit = $TextEdit

func _ready() -> void:
	pass # Replace with function body.

func _on_restart_pressed() -> void:
	Restart_Pressed.emit()

func _on_menu_pressed() -> void:
	Menu_Pressed.emit()

func _on_send_pressed() -> void:
	Send_Pressed.emit(text_edit.text)
