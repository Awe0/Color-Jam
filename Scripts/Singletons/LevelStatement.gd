extends Node


var level_state : Dictionary = {
	"level 1" : false,
	"level 2" : false,
	"level 3" : false,
	"level 4" : false,
	"level 5" : false,
	"level 6" : false,
	"level 7" : false,
	"level 8" : false,
	"level 9" : false,
	"level 10" : false,
	"level 11" : false,
	"level 12" : false,
	"level 13" : false,
	"level 14" : false,
	"level 15" : false,
	"level 16" : false,
}

func _ready() -> void:
	for level in level_state:
		level_state[level] = SaveSystem.load_levels_data(level)
