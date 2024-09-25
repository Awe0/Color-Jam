extends Node

const SAVE_CONFIG_DIRECTION: String = "user://save_config.cfg"

func save_config(section: String, key: String, value: Variant):
	var config_file = ConfigFile.new()
	config_file.set_value(section, key, value)
	config_file.save(SAVE_CONFIG_DIRECTION)

func load_config(key: String):
	var config_data: Dictionary = {}
	var config_file = ConfigFile.new()
	var err: Error = config_file.load(SAVE_CONFIG_DIRECTION)
	
	if err != OK:
		return
	
	for section in config_file.get_sections():
		var config_saved = config_file.get_value(section, key)
		if config_saved != null:
			config_data[key] = config_saved
	
	return config_data
