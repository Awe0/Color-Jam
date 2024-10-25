extends Node

var level_state: Dictionary = {
	"level_1" : {"locked" : true, "state" : false, "attempt" : 999},
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

var level_attempt: Dictionary = {
	"level_1" : [33,37,41],
	"level_2" : [27,31,35],
	"level_3" : [23,37,32],
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
	SignalBus.Level_state_change.connect(update_level_state)
	update_level_state()

func update_level_state():
	level_state = SaveSystem.load_levels_data()
