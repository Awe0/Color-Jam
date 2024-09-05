extends Control

@onready var label: Label = $VBoxContainer/Label
@onready var button: Button = $VBoxContainer/Button

func _ready() -> void:
	SignalBus.popup_displayed.connect(on_popup_displayed)

func on_popup_displayed(text_error):
	print("SIGNAL EMITED")
	label.text = text_error
