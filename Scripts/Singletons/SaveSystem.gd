extends Node

var level_state: Dictionary = {
	"level_1" : {"locked" : false, "state" : false, "attempt" : 999},
	"level_2" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_3" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_4" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_5" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_6" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_7" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_8" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_9" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_10" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_11" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_12" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_13" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_14" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_15" : {"locked" : true, "state" : false, "attempt" : 999},
	"level_16" : {"locked" : true, "state" : false, "attempt" : 999},
}

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
	var levels_initialized = config_file.get_value("settings", "levels_initialized")
	
	if not levels_initialized:
		# Si les niveaux n'ont pas été initialisés, sauvegarde l'état des niveaux
		for level in level_state.keys():
			# Vérifie que la clé n'est pas "settings"
			if level != "settings":
				# Crée une section pour chaque niveau
				config_file.set_value(level, "state", level_state[level]["state"])
				var attempt = level_state[level]["attempt"]
				config_file.set_value(level, "attempt", attempt)
		
		# Marque les niveaux comme initialisés pour ène pas réécrire les données
		config_file.set_value("settings", "levels_initialized", true)
		
		# Sauvegarde les changements dans le fichier
		err = config_file.save(SAVE_LEVELS_DIRECTION)
		if err != OK:
			print("Erreur lors de la sauvegarde du fichier de configuration")
		else:
			print("États des niveaux initialisés et sauvegardés.")
			SignalBus.Level_state_change.emit()
	else:
		print("Les niveaux ont déjà été initialisés.")

func update_levels_data():
	var config_file = ConfigFile.new()
	var err = config_file.load(SAVE_LEVELS_DIRECTION)
	
	if err != OK and err != ERR_FILE_NOT_FOUND:
		print("Erreur lors du chargement du fichier de configuration")
		return

	# Parcourt chaque niveau dans le dictionnaire en mémoire
	for level in level_state.keys():
		# Crée la section de niveau si elle n'existe pas
		if not config_file.has_section(level):
			config_file.set_value(level, "locked", level_state[level]["locked"])
			config_file.set_value(level, "state", level_state[level]["state"])
			config_file.set_value(level, "attempt", level_state[level]["attempt"])
			print("Nouvelle section ajoutée pour :", level)
		else:
			# Vérifie et ajoute les clés manquantes
			for key in level_state[level].keys():
				if not config_file.has_section_key(level, key):
					config_file.set_value(level, key, level_state[level][key])
					print("Clé ajoutée pour", level, ":", key)

	# Sauvegarde les changements dans le fichier
	err = config_file.save(SAVE_LEVELS_DIRECTION)
	if err != OK:
		print("Erreur lors de la mise à jour du fichier de configuration")
	else:
		print("Fichier de configuration mis à jour avec succès pour les nouveaux niveaux.")
