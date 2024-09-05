extends Node2D

@export var size = 0
@export var score = 0
@export var color_name = ""
@onready var texture_rect: TextureRect = $TextureRect
var is_vertical = true
var start_position = Vector2(-1, -1)

func _ready() -> void:
	texture_rect.texture = load("res://Assets/"+color_name+"_preview.png")
