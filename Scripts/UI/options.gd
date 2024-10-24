extends Control

@onready var rotation_mode_button: CheckButton = $CheckButtonContainer/CheckButtons/RotationModeButton
@onready var dark_mode_button: CheckButton = $CheckButtonContainer/CheckButtons/DarkModeButton
@onready var music_slider: HSlider = $Sliders/MusicSlider
@onready var sound_slider: HSlider = $Sliders/SoundSlider

var options: Dictionary = {}

func _ready() -> void:
	options = {
	"rotation_mode" : rotation_mode_button,
	"dark_mode" : dark_mode_button,
	"music_db" : music_slider,
	"sound_db" : sound_slider,
	}
	set_config_saved()

func restart_button_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/Menu/Level_Select.tscn")

func set_config_saved():
	for option_string in options.keys():
		var option_object = options[option_string]
		var config_data = SaveSystem.load_config(option_string)
		
		if config_data != null:
			if option_object is CheckButton:
				option_object.button_pressed = config_data.get(option_string, false)
			
			elif option_object is HSlider or option_object is VSlider:
				option_object.value = config_data.get(option_string, 0.0)
		else:
			if option_object is CheckButton:
				option_object.button_pressed = false
			elif option_object is HSlider or option_object is VSlider:
				option_object.value = 0.0


func _on_rotation_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "rotation_mode", toggled_on)
	Config.rotation_mode = toggled_on

func _on_dark_mode_button_toggled(toggled_on: bool) -> void:
	SaveSystem.save_config("game", "dark_mode", toggled_on)
	Config.dark_mode = toggled_on

func _on_exit_pressed() -> void:
	queue_free()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_achievement_pressed() -> void:
	AchievementsClient.show_achievements()

func _on_leaderboard_pressed() -> void:
	var current_scene_name = get_tree().current_scene.name
	if Leaderboards.LEADERBOARDS_ID[current_scene_name]:
		LeaderboardsClient.show_leaderboard(Leaderboards.LEADERBOARDS_ID[current_scene_name])

func _on_music_slider_value_changed(value: float) -> void:
	AudioPlayer.music_player.volume_db = value
	SaveSystem.save_config("game", "music_db", value)

func _on_sound_slider_value_changed(value: float) -> void:
	AudioPlayer.fx_player.volume_db = value
	SaveSystem.save_config("game", "sound_db", value)

func _on_help_pressed() -> void:
	var scene_instance = PreloadScenes.help_scene.instantiate()
	get_tree().root.add_child(scene_instance)
