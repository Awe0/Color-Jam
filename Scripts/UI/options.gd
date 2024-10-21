extends Control

@onready var rotation_mode_button: CheckButton = $CheckButtonContainer/CheckButtons/RotationModeButton
@onready var dark_mode_button: CheckButton = $CheckButtonContainer/CheckButtons/DarkModeButton
@onready var music_slider: HSlider = $Sliders/MusicSlider
@onready var sound_slider: HSlider = $Sliders/SoundSlider

var list_check_button: Array = []
var list_sliders: Array = []

const LIST_OPTIONS_STRING: Array = [
	"rotation_mode",
	"dark_mode",
	#"music_db",
	#"sound_db"
]

func _ready() -> void:
	list_check_button = [rotation_mode_button, dark_mode_button]
	list_sliders = [music_slider, sound_slider]
	set_config_saved()

func restart_button_pressed() -> void:
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
		#list_sliders[i].value = Config.list_options[i]
		

func _on_rotation_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "rotation_mode", toggled_on)
	Config.rotation_mode = toggled_on

func _on_dark_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "dark_mode", toggled_on)
	Config.dark_mode = toggled_on

func _on_exit_pressed() -> void:
	$".".visible = false

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_achievement_pressed() -> void:
	pass

func _on_leaderboard_pressed() -> void:
	var current_scene_name = get_tree().current_scene.name
	if Leaderboards.LEADERBOARDS_ID[current_scene_name]:
		LeaderboardsClient.show_leaderboard(Leaderboards.LEADERBOARDS_ID[current_scene_name])

func _on_account_pressed() -> void:
	PlayersClient.load_current_player(true)

func _on_music_slider_value_changed(value: float) -> void:
	AudioPlayer.music_player.volume_db = value
	SaveSystem.save_config("game", "music_db", value)

func _on_sound_slider_value_changed(value: float) -> void:
	AudioPlayer.fx_player.volume_db = value
	SaveSystem.save_config("game", "sound_db", value)
