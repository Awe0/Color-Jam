extends Control

@onready var message_timer: Timer = $Messages/Timer
@onready var failed: Label = $Messages/Failed
@onready var success: Label = $Messages/Success

var _sign_in_retries := 5

func _ready() -> void:
	if not GodotPlayGameServices.android_plugin:
		display_label_and_start_timer(failed)
	
	SignInClient.user_authenticated.connect(func(is_authenticated: bool):
		if _sign_in_retries > 0 and not is_authenticated:
			print("Trying to sign in!")
			SignInClient.sign_in()
			_sign_in_retries -= 1
		
		if _sign_in_retries == 0:
			print("Sign in attemps expired!")
		
		if is_authenticated:
			get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	)

func _on_timer_timeout(label: Label) -> void:
	label.visible = false

func display_label_and_start_timer(label: Label):
	label.visible = true
	message_timer.start(5)
	message_timer.timeout.connect(func() -> void:_on_timer_timeout(label))
