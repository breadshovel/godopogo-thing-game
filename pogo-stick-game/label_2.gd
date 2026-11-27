extends Label

var sound = preload("res://Sounds/laserShoot.wav")

var time_left_decimal

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	text = str(snapped($"../../InGameTimer".time_left, 1))
	
	time_left_decimal = $"../../InGameTimer".time_left - int($"../../InGameTimer".time_left) 
	
	if $"../../InGameTimer".time_left < 10 and time_left_decimal >= .9: 
		visible = true 
		SoundSystem.play_audiostream(sound, 0, 3)
	else: 
		visible = false
