extends Node

var game_win_scene = preload("res://Scenes/Game/UI/Game_Win.tscn")
var game_over_scene = preload("res://Scenes/Game/UI/Game_Over.tscn")
var option_scene = preload("res://Scenes/Game/UI/Options.tscn")
var help_scene = preload("res://Scenes/Help/Help.tscn")
var scene_ui = preload("res://Scenes/Game/UI/Game_UI.tscn")

const LEVEL_INSTANCES: Dictionary = {
	"level_1" : preload("res://Scenes/Game/Levels/Level_1.tscn"),
	"level_2" : preload("res://Scenes/Game/Levels/Level_2.tscn"),
	"level_3" : preload("res://Scenes/Game/Levels/Level_3.tscn"),
	"level_4" : preload("res://Scenes/Game/Levels/Level_4.tscn"),
	"level_5" : preload("res://Scenes/Game/Levels/Level_5.tscn"),
	"level_6" : preload("res://Scenes/Game/Levels/Level_6.tscn"),
	"level_7" : preload("res://Scenes/Game/Levels/Level_7.tscn"),
	"level_8" : preload("res://Scenes/Game/Levels/Level_8.tscn"),
	"level_9" : preload("res://Scenes/Game/Levels/Level_9.tscn"),
	"level_10" : preload("res://Scenes/Game/Levels/Level_10.tscn"),
	"level_11" : preload("res://Scenes/Game/Levels/Level_11.tscn"),
	"level_12" : preload("res://Scenes/Game/Levels/Level_12.tscn"),
	"level_13" : preload("res://Scenes/Game/Levels/Level_13.tscn"),
	"level_14" : preload("res://Scenes/Game/Levels/Level_14.tscn"),
	"level_15" : preload("res://Scenes/Game/Levels/Level_15.tscn"),
	"level_16" : preload("res://Scenes/Game/Levels/Level_16.tscn")
}
