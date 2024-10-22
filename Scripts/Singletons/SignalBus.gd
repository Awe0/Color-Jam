extends Node

signal Restart_Game()
signal Score_changed(score: int)
signal Level_up(level: int)

#Signaux pour l'UI IG
signal Game_is_over()
signal Rotating
signal Rerolling
signal Deleting
signal Check_Grid

signal Level_is_selected(level_name: String)
