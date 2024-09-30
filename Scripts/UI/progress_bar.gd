extends ProgressBar

@onready var progress_bar: ProgressBar = $"."

func _ready() -> void:
	SignalBus.Score_changed.connect(update_progress_bar)

func update_progress_bar(score: int):
	progress_bar.value = score
	#print("max value = " + str(progress_bar.max_value))
	#print("actual value = " + str(progress_bar.value))
	if progress_bar.value == progress_bar.max_value:
		progress_bar.value = 0
		#if level != 1:
			#progress_bar.max_value = 80 
			#level += 1
			#level_label.text = "Level " + str(level)
		#else:
			#level += 1
