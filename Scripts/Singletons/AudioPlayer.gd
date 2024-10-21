extends Node

const GAME_MUSIC = preload("res://Assets/Sound/Music/puzzle-game-loop-bright-casual-video-game-music-249201.mp3")
const BUBBLE_SOUND_1 = preload("res://Assets/Sound/Bubbles/104940__glaneur-de-sons__bubble-1.wav")
const BUBBLE_SOUND_2 = preload("res://Assets/Sound/Bubbles/104941__glaneur-de-sons__bubble-2.wav")
const BUBBLE_SOUND_3 = preload("res://Assets/Sound/Bubbles/104942__glaneur-de-sons__bubble-3.wav")
const BUBBLE_SOUND_4 = preload("res://Assets/Sound/Bubbles/104943__glaneur-de-sons__bubble-4.wav")
const BUBBLE_SOUND_5 = preload("res://Assets/Sound/Bubbles/104944__glaneur-de-sons__bubble-5.wav")
const BUBBLE_SOUND_6 = preload("res://Assets/Sound/Bubbles/104945__glaneur-de-sons__bubble-6.wav")
const BUBBLE_SOUND_7 = preload("res://Assets/Sound/Bubbles/104946__glaneur-de-sons__bubble-7.wav")
const BUBBLE_SOUND_8 = preload("res://Assets/Sound/Bubbles/104947__glaneur-de-sons__bubble-8.wav")
const BUBBLE_SOUND_9 = preload("res://Assets/Sound/Bubbles/104948__glaneur-de-sons__bubble-9.wav")

var bubbles_sound: Array = []

var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var fx_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music_player)
	add_child(fx_player)

	bubbles_sound = [
		BUBBLE_SOUND_1,
		BUBBLE_SOUND_2,
		BUBBLE_SOUND_3,
		BUBBLE_SOUND_4,
		BUBBLE_SOUND_5,
		BUBBLE_SOUND_6,
		BUBBLE_SOUND_7,
		BUBBLE_SOUND_8,
		BUBBLE_SOUND_9
	]
	
	play_music_game()

func _play_music(music: AudioStream, volume = 0.0):
	if music_player.stream == music:
		return
	
	music_player.stream = music
	music_player.volume_db = volume
	music_player.stream.loop = true
	music_player.play()

func play_music_game():
	_play_music(GAME_MUSIC)

func play_FX(stream: AudioStream):
	fx_player.stream = stream
	fx_player.play()

func play_random_bubble_FX():
	var random_index = randi() % bubbles_sound.size()
	var new_sound = bubbles_sound[random_index]
	play_FX(new_sound)
