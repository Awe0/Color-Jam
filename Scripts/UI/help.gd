extends Control

signal Quit_Pressed()

@onready var step_1: Control = $Step1
@onready var step_2: Control = $Step2
@onready var step_3: Control = $Step3
@onready var step_4: Control = $Step4

var step_visibility = 1

func _on_step_1_next_pressed() -> void:
	if step_visibility == 1:
		if step_1.visible == true:
			step_1.visible = false
			step_2.visible = true
			step_visibility += 1

func _on_step_2_next_pressed() -> void:
	if step_visibility == 2:
		if step_2.visible == true:
			step_3.visible = true
			step_2.visible = false
			step_visibility += 1

func _on_step_3_next_pressed() -> void:
	if step_visibility == 3:
		if step_3.visible == true:
			step_4.visible = true
			step_3.visible = false
			step_visibility += 1

func _on_step_2_back_pressed() -> void:
	if step_visibility == 2:
		if step_2.visible == true:
			step_1.visible = true
			step_2.visible = false
			step_visibility -= 1

func _on_step_3_back_pressed() -> void:
	if step_visibility == 3:
		if step_3.visible == true:
			step_2.visible = true
			step_3.visible = false
			step_visibility -= 1

func _on_step_4_back_pressed() -> void:
	if step_visibility == 4:
		if step_4.visible == true:
			step_3.visible = true
			step_4.visible = false
			step_visibility -= 1

func _on_step_1_quit_pressed() -> void:
	step_visibility = 1
	reset_step_visibility()
	Quit_Pressed.emit()

func _on_step_2_quit_pressed() -> void:
	step_visibility = 1
	reset_step_visibility()
	Quit_Pressed.emit()

func _on_step_3_quit_pressed() -> void:
	step_visibility = 1
	reset_step_visibility()
	Quit_Pressed.emit()

func _on_step_4_quit_pressed() -> void:
	step_visibility = 1
	reset_step_visibility()
	Quit_Pressed.emit()

func reset_step_visibility():
	step_1.visible = true
	step_2.visible = false
	step_3.visible = false
	step_4.visible = false
	#match step_visibility:
		#1:
			#step_1.visible = true
		#2:
			#step_2.visible = true
		#3:
			#step_3.visible = true
		#4:
			#step_4.visible = true
