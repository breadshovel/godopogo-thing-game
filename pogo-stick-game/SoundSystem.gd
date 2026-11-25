extends Node

var player: AudioStreamPlayer
var death: AudioStream = preload("res://shepard_tone_20000ms.wav")

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)

func load_audiostream(path: StringName):
	return load(path)

func play_audiostream(stream: AudioStream, fromPosition: float = 0.0, pitch_scale: float = 1.0):
	player.stream = stream
	player.pitch_scale = pitch_scale
	player.play(fromPosition)

func play_death_sound():
	player.stream = death
	player.play(.5)

# does death sequence
var tick := 0.0
var tick2 := 0.0
const DEATH_SEQ_LENGTH: float = 1

func check_death_sequence(plr: Player, deathScreen: Sprite2D, delta: float, time_left):
		print("check_death_sequence was called")
		tick += delta
		tick2 += delta
		
		play_death_sound()
		deathScreen.visible = true
		
		#flash death screen back and forth every frame
		print(tick)
		if tick >= .05:
			if deathScreen.texture.resource_path == "res://deathscreenframe1.png":
				deathScreen.texture = load("res://deathscreenframe2.png")
			else:
				deathScreen.texture = load("res://deathscreenframe1.png")
				
			tick = 0
			if !deathScreen.visible: tick2 = 0
			
		#reset game
		if tick2 >= DEATH_SEQ_LENGTH:
			get_tree().change_scene_to_file("res://titlescreen.tscn")
			player.stop()
