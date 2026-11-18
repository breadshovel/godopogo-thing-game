extends Node3D

@onready var timer = $"START GAME TIMER"
var game_start
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	
func start() -> void:
	$"START GAME TIMER/Timer".start()
	game_start = false
	timer.wait_time = 4.0
	timer.start() # Replace with function body.
	
var wave := 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if timer.time_left <= 3 and timer.time_left >= 2:
		$"CanvasLayer/GAME START SCREEN/Label".visible = true
		$"CanvasLayer/GAME START SCREEN/Label3".visible = false
	if timer.time_left <= 2 and timer.time_left >= 1:
		$"CanvasLayer/GAME START SCREEN/Label2".visible = true
	if timer.time_left <= 1 and timer.time_left >= 0:
		$"CanvasLayer/GAME START SCREEN/Label3".text = "WAVE " + str(wave)
		$"CanvasLayer/GAME START SCREEN/Label".visible = false
		$"CanvasLayer/GAME START SCREEN/Label2".visible = false
		$"CanvasLayer/GAME START SCREEN/Label3".visible = true
	print($"START GAME TIMER".time_left)


func _on_start_game_timer_timeout() -> void:
	$"CanvasLayer/GAME START SCREEN".visible = false
	$"CanvasLayer/GAME START SCREEN/Label".visible = false
	$"CanvasLayer/GAME START SCREEN/Label2".visible = false
	$"CanvasLayer/GAME START SCREEN/Label3".visible = false
	game_start = true
	timer.stop() # Replace with function body.
	#$BackgroundMusic.start()



#-------------BOOM SOUND AAAAAAAAAAAAA------------------------

func _on_timer_timeout() -> void:
	if !game_start and timer.time_left >= .1:
		$Boom.play()
	else:
		$"START GAME TIMER/Timer".stop() # Replace with function body.
