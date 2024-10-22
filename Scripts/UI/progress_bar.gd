extends ProgressBar

@onready var progress_bar: ProgressBar = $"."

func _ready() -> void:
	SignalBus.Restart_game.connect(reset_progress_bar)
	SignalBus.Score_changed.connect(update_progress_bar)
	SignalBus.Level_up.connect(change_max_value)
	progress_bar.max_value = 100

func change_max_value(level: int):
	progress_bar.value = 0
	progress_bar.max_value = 80

func update_progress_bar(score: int):
	progress_bar.value += score

func reset_progress_bar():
	progress_bar.max_value = 100
	progress_bar.value = 0
