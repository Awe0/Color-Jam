extends ProgressBar

@onready var progress_bar: ProgressBar = $"."
@onready var _3_nd_star: TextureRect = $"3ndStar"
@onready var _2_nd_star: TextureRect = $"2ndStar"
@onready var _1_st_star: TextureRect = $"1stStar"

var value_steps = [0,0,0]

func _ready() -> void:
	SignalBus.Level_is_selected.connect(set_max_value)
	SignalBus.Attempt_changed.connect(update_progress_bar)

func set_max_value(level_name):
	value_steps[0] = LevelStatement.level_attempt[level_name][0]
	value_steps[1] = LevelStatement.level_attempt[level_name][1]
	value_steps[2] = LevelStatement.level_attempt[level_name][2]
	
	progress_bar.max_value = value_steps[2]
	progress_bar.value = value_steps[2]

func update_progress_bar(attempt: int):
	print("Value bar : " + str(progress_bar.value))
	print("attempt : " + str(attempt))
	progress_bar.value -= 1
	
	if attempt == value_steps[0]:
		_1_st_star.visible = false
	elif attempt == value_steps[1]:
		_2_nd_star.visible = false
	elif attempt == value_steps[2]:
		_3_nd_star.visible = false
