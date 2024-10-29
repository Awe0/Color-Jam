extends Node

signal Restart_game

#Signaux pour l'UI IG
signal Game_is_over
signal Rotating
signal Rerolling
signal Deleting
signal Stocking
signal Check_Grid
signal Game_is_win
signal Attempt_increased
signal Send_the_actual_level_name(level_name: String)

signal Level_is_selected(level_name: String)
signal Level_state_change
signal Level_completed(level_name: String, attempt: int)

signal Attempt_changed(attempt: int)
