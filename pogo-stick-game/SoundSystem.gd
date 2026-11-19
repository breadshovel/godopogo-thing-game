extends Node

var player: AudioStreamPlayer

var tromboing: Resource = preload("res://07 Tromboing.mp3")
var boom: Resource = preload("res://universfield-impact-cinematic-boom-02-487858.mp3")
var shoot: Resource = preload("res://laserShoot.wav")
var death: Resource = preload("res://universfield-dramatic-death-collapse-352720.mp3")

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)

func play_tromboing():
	player.stream = tromboing
	player.play()

func play_shoot_sound():
	player.stream = shoot
	player.play()

func play_boom_sound():
	player.stream = boom
	player.play()

func play_death_sound():
	player.stream = death
	player.play()

# does death sequence
var tick := 0.0
var tick2 := 0.0

func check_death_sequence(player: Player, deathScreen: Sprite2D, delta: float):
	if player.controller.health <= 0:
		tick += 1 * delta
		tick2 += 1 * delta
		
		#detect if dead
		if player.controller.health <= 0:
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
		if tick2 >= .7:
			get_tree().reload_current_scene()
