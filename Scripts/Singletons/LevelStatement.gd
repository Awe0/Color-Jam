extends Node

var level_state: Dictionary = {
	"level_1" : {"state" : false, "attempt" : 999},
	"level_2" : {"state" : false, "attempt" : 999},
	"level_3" : {"state" : false, "attempt" : 999},
	"level_4" : {"state" : false, "attempt" : 999},
	"level_5" : {"state" : false, "attempt" : 999},
	"level_6" : {"state" : false, "attempt" : 999},
	"level_7" : {"state" : false, "attempt" : 999},
	"level_8" : {"state" : false, "attempt" : 999},
	"level_9" : {"state" : false, "attempt" : 999},
	"level_10" : {"state" : false, "attempt" : 999},
	"level_11" : {"state" : false, "attempt" : 999},
	"level_12" : {"state" : false, "attempt" : 999},
	"level_13" : {"state" : false, "attempt" : 999},
	"level_14" : {"state" : false, "attempt" : 999},
	"level_15" : {"state" : false, "attempt" : 999},
	"level_16" : {"state" : false, "attempt" : 999},
}

var level_attempt: Dictionary = {
	"level_1" : [33,37,41],
	"level_2" : [27,31,35],
	"level_3" : [27,31,35],
	"level_4" : [27,31,35],
	"level_5" : [27,31,35],
	"level_6" : [27,31,35],
	"level_7" : [27,31,35],
	"level_8" : [27,31,35],
	"level_9" : [27,31,35],
	"level_10" : [27,31,35],
	"level_11" : [27,31,35],
	"level_12" : [27,31,35],
	"level_13" : [27,31,35],
	"level_14" : [27,31,35],
	"level_15" : [27,31,35],
	"level_16" : [27,31,35],
}

func _ready() -> void:
	for level in level_state:
		level_state = SaveSystem.load_levels_data()
	print(level_state)
