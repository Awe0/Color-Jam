extends Control

@onready var texture_button: TextureButton = $VBoxContainer/HBoxContainer2/TextureButton
@onready var rotation_mode_button: CheckButton = $VBoxContainer/RotationMode/RotationModeButton
@onready var dark_mode_button: CheckButton = $VBoxContainer/DarkMode/DarkModeButton

var list_check_button: Array = []

const LIST_OPTIONS_STRING: Array = [
	"rotation_mode",
	"dark_mode"
]

func _ready() -> void:
	list_check_button = [rotation_mode_button, dark_mode_button]
	set_config_saved()

func _on_texture_button_pressed() -> void:
	SignalBus.Restart_Game.emit()

func set_config_saved():
	for i in range(LIST_OPTIONS_STRING.size()):
		var option_string = LIST_OPTIONS_STRING[i]
		var config_data = SaveSystem.load_config(option_string)
		
		if config_data == null:
			Config.list_options[i] = false
		else:
			Config.list_options[i] = config_data.get(option_string, false)
		
		list_check_button[i].button_pressed = Config.list_options[i]

func _on_rotation_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "rotation_mode", toggled_on)
	Config.rotation_mode = toggled_on

func _on_dark_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "dark_mode", toggled_on)
	Config.dark_mode = toggled_on
