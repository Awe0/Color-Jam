extends Control

signal Quit_Pressed

@onready var step_1: Label = $Step1

const HELP_MESSAGES: Array = [
	"Bienvenue dans Color Jam!
	Le but est simple : 
	il vous suffit de remplir 
	une grille de 10x10 cases 
	en plaçant des pièces de différentes tailles, 
	allant de 1 à 5 cases. 
	Les pièces apparaissent de façon aléatoire, 
	alors à vous de bien réfléchir où les placer !"
	, 
	"À partir du niveau 2, les choses se compliquent.
	La grille sera déjà partiellement
	remplie par des blocs gris.
	 Cela signifie que vous devrez faire
	preuve d’encore plus de stratégie pour
	caser les nouvelles pièces dans les espaces restants."
	,
	"Pour vous aider, vous disposez de
	deux types de bonus dès le début :

	Delete : Si la pièce à venir ne vous convient pas,
			utilisez ce bonus pour la supprimer.

	Reroll : Ce bonus vous permet de changer la pièce 
	à venir de manière aléatoire.

	Vous commencez avec 2 utilisations de chaque.
	À chaque nouveau niveau franchi,
	vous gagnez 2 utilisations supplémentaires 
	pour chaque bonus !"
	,
	"Le jeu se termine lorsque vous ne pouvez plus 
	placer de pièces sur la grille. 
	Lorsque cela se produit, vous pourrez entrer 
	votre nom afin qu'il soit enregistré dans le
	tableau des scores général et rivaliser 
	avec les joueuses et joueurs du monde entier.

	Bonne chance !"
]
var steps = 0

func _ready() -> void:
	help_label.text = HELP_MESSAGES[steps]

func _on_next_pressed() -> void:
	steps += 1
	help_label.text = HELP_MESSAGES[steps]

func _on_quit_pressed() -> void:
	Quit_Pressed.emit()
