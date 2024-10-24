extends Node

signal Restart_game
signal Score_changed(score: int)
signal Level_up(level: int)

#Signaux pour l'UI IG
signal Game_is_over
signal Rotating
signal Rerolling
signal Deleting
signal Stocking
signal Check_Grid
signal Game_is_win
signal Attempt_increased

signal Level_is_selected(level_name: String)

signal Level_state_change
