extends Control

@onready var texture_rect: TextureRect = $TextureRect
const ROTATION_DEGREE = -1.57079994678497

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.rotate.connect(rotate_piece)

func rotate_piece():
	if texture_rect.rotation == 0:
		texture_rect.rotation = -1.57079994678497
	elif texture_rect.rotation != 0:
		texture_rect.rotation = 0
