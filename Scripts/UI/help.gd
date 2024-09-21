extends Label

signal Quit_Pressed

@onready var help_label: Label = $"."

const HELP_MESSAGES: Array = ["Bienvenue dans Color Jam!
Le but est simple : 
il vous suffit de remplir 
une grille de 10x10 cases 
en plaçant des pièces de différentes tailles, 
allant de 1 à 5 cases. 
Les pièces apparaissent de façon aléatoire, 
alors à vous de bien réfléchir où les placer !", "Step 2", "Step 3"]
var steps = 0

func _ready() -> void:
	help_label.text = HELP_MESSAGES[steps]



func _on_next_pressed() -> void:
	steps += 1
	help_label.text = HELP_MESSAGES[steps]

func _on_quit_pressed() -> void:
	Quit_Pressed.emit()
