extends Label

var sound = preload("res://Sounds/09 Kabong.mp3")

func _ready() -> void:
	visible = false
	SignalBus.announcer_signal.connect(announce)

func announce(displaytext, onscreentime):
	text = displaytext
	$HideTimer.start(onscreentime)
	SoundSystem.play_audiostream(sound, .15, 2)
	visible = true
	


func _on_color_change_timer_timeout() -> void:
	add_theme_color_override("font_color", Color.from_hsv(randf_range(0, 1),1,1,1))


func _on_hide_timer_timeout() -> void:
	visible = false
