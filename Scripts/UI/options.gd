extends Control

@onready var texture_button: TextureButton = $VBoxContainer/HBoxContainer2/TextureButton
@onready var rotation_mode_button: CheckButton = $VBoxContainer/RotationMode/RotationModeButton
@onready var dark_mode_button: CheckButton = $VBoxContainer/DarkMode/DarkModeButton

const LIST_OPTIONS_STRING: Array = [
	"rotation_mode",
	"dark_mode"
]


func _ready() -> void:
	set_config_saved()

func _on_texture_button_pressed() -> void:
	SignalBus.Restart_Game.emit()

func set_config_saved():
	var config_data: Dictionary = {}
	for option_string in LIST_OPTIONS_STRING:
		if SaveSystem.load_config(option_string) == null:
			for option in Config.lis
			Config.rotation_mode = false
		else:
			config_data = SaveSystem.load_config("rotation_mode")
			Config.rotation_mode = config_data["rotation_mode"]
	rotation_mode_button.button_pressed = Config.rotation_mode

func _on_rotation_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "rotation_mode", toggled_on)
	Config.rotation_mode = toggled_on

func _on_dark_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "dark_mode", toggled_on)
	Config.dark_mode = toggled_on
