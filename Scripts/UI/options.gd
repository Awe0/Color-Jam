extends Control

@onready var texture_button: TextureButton = $VBoxContainer/HBoxContainer2/TextureButton
@onready var check_button: CheckButton = $VBoxContainer/HBoxContainer/CheckButton

func _ready() -> void:
	set_config_saved()

func _on_texture_button_pressed() -> void:
	SignalBus.Restart_Game.emit()

func _on_check_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "rotation_mode", toggled_on)
	Config.rotation_mode = toggled_on

func set_config_saved():
	var config_data: Dictionary = {}
	if SaveSystem.load_config("rotation_mode") == null:
		Config.rotation_mode = false
	else:
		config_data = SaveSystem.load_config("rotation_mode")
		Config.rotation_mode = config_data["rotation_mode"]
	check_button.button_pressed = Config.rotation_mode
