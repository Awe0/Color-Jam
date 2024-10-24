extends Node

const SAVE_CONFIG_DIRECTION: String = "user://save_config.cfg"
const SAVE_LEVELS_DIRECTION: String = "user://save_levels_data.cfg"

func save_config(section: String, key: String, value: Variant):
	var config_file = ConfigFile.new()
	var err = config_file.load(SAVE_CONFIG_DIRECTION)
	
	if err != OK and err != ERR_FILE_NOT_FOUND:
		print("Erreur lors du chargement du fichier de configuration")
		return
	
	config_file.set_value(section, key, value)
	
	err = config_file.save(SAVE_CONFIG_DIRECTION)
	if err != OK:
		print("Erreur lors de la sauvegarde du fichier de configuration")

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

func save_levels_data(section: String, key: String, value: Variant):
	var config_file = ConfigFile.new()
	var err = config_file.load(SAVE_LEVELS_DIRECTION)
	
	if err != OK and err != ERR_FILE_NOT_FOUND:
		print("Erreur lors du chargement du fichier de configuration")
		return
	
	config_file.set_value(section, key, value)
	
	err = config_file.save(SAVE_LEVELS_DIRECTION)
	if err != OK:
		print("Erreur lors de la sauvegarde du fichier de configuration")

func load_levels_data():
	var config_data: Dictionary = {}
	var config_file = ConfigFile.new()
	var err: Error = config_file.load(SAVE_LEVELS_DIRECTION)
	
	if err != OK:
		print("Erreur lors du chargement du fichier:", err)
		return
	
	# Parcourt chaque section (ex: "level_1", "level_2", etc.)
	for section in config_file.get_sections():
		config_data[section] = {}
		
		# Parcourt chaque clé dans la section (ex: "state", "attempt", etc.)
		for key in config_file.get_section_keys(section):
			config_data[section][key] = config_file.get_value(section, key)
	
	return config_data

func reset_levels_data():
	var config_file = ConfigFile.new()
	var err = config_file.load(SAVE_LEVELS_DIRECTION)
	if err != OK and err != ERR_FILE_NOT_FOUND:
		print("Erreur lors du chargement du fichier de configuration")
		return
	for section in config_file.get_sections():
		config_file.erase_section(section)
	err = config_file.save(SAVE_LEVELS_DIRECTION)
	if err != OK:
		print("Erreur lors de la réinitialisation du fichier de configuration")
	else:
		print("Fichier de configuration réinitialisé avec succès")

func initialize_levels():
	var config_file = ConfigFile.new()
	var err = config_file.load(SAVE_LEVELS_DIRECTION)
	
	if err != OK and err != ERR_FILE_NOT_FOUND:
		print("Erreur lors du chargement du fichier de configuration")
		return
	
	# Vérifie si les niveaux ont déjà été initialisés
	var levels_initialized = config_file.get_value("settings", "levels_initialized", false)
	
	if not levels_initialized:
		# Si les niveaux n'ont pas été initialisés, sauvegarde l'état des niveaux
		for level in LevelStatement.level_state.keys():
			config_file.set_value(level, "state", false)
		
		# Marque les niveaux comme initialisés pour ne pas réécrire les données
		config_file.set_value("settings", "levels_initialized", true)
		
		# Sauvegarde les changements dans le fichier
		err = config_file.save(SAVE_LEVELS_DIRECTION)
		if err != OK:
			print("Erreur lors de la sauvegarde du fichier de configuration")
		else:
			print("États des niveaux initialisés et sauvegardés.")
	else:
		print("Les niveaux ont déjà été initialisés.")
