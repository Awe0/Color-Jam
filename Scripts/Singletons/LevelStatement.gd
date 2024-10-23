extends Node


var level_state : Dictionary = {
	"level_1" : false,
	"level_2" : false,
	"level_3" : false,
	"level_4" : false,
	"level_5" : false,
	"level_6" : false,
	"level_7" : false,
	"level_8" : false,
	"level_9" : false,
	"level_10" : false,
	"level_11" : false,
	"level_12" : false,
	"level_13" : false,
	"level_14" : false,
	"level_15" : false,
	"level_16" : false,
}

func _ready() -> void:
	for level in level_state:
		level_state[level] = SaveSystem.load_levels_data(level)
