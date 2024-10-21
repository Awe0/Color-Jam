extends AudioStreamPlayer

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

func _ready() -> void:
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

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	stream.loop = true
	volume_db = volume
	play()

func play_music_game():
	_play_music(GAME_MUSIC)

func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()

func play_random_bubble_FX():
	var random_index = randi() % bubbles_sound.size()
	var new_sound = bubbles_sound[random_index]
	play_FX(new_sound)
