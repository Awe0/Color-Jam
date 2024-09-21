extends Label

signal Restart_Pressed
signal Menu_Pressed

@onready var text_edit: TextEdit = $TextEdit
@onready var failed: Label = $Failed
@onready var timer: Timer = $Timer
@onready var succes: Label = $Succes
@onready var send_button: Button = $Send

func _ready() -> void:
	send_button.visible = true

func _on_restart_pressed() -> void:
	send_button.visible = true
	Restart_Pressed.emit()

func _on_menu_pressed() -> void:
	Menu_Pressed.emit()

func _on_send_pressed() -> void:
	if text_edit.text:
		failed.visible = false
		succes.visible = true
		timer.start(5)
		SignalBus.Username_sended.emit(text_edit.text)
		send_button.visible = false
	else:
		failed.visible = true
		timer.start(5)

func _on_timer_timeout() -> void:
	failed.visible = false
	succes.visible = false
