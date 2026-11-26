extends Node3D

const COMBO_START_THRESHOLD = 3
const COMBO_RUNOUT_TIME = 2

var combo_count = 0
var displayed_combo_count = 0
var in_combo = false

@onready var timer = $ComboRunoutTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.enemy_died.connect(add_to_combo) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	displayed_combo_count = combo_count - COMBO_START_THRESHOLD + 1
	

#PLANNING
#everytime an enemy dies, it sends signal to the combo system

#when enemy die:
#	reset combo timer
#	combo count += 1
#	if combo count == COMBO START THRESHOLD:
#		emit signal "combo started"

#on timer run out:
#	combo count = 0
#   emit signal "combo ended"

func add_to_combo():
	timer.start(COMBO_RUNOUT_TIME)
	combo_count += 1
	if combo_count == COMBO_START_THRESHOLD:
		SignalBus.combo_started.emit()
		in_combo = true

func _on_combo_runout_timer_timeout() -> void:
	combo_count = 0
	SignalBus.combo_ended.emit()
	in_combo = false
	timer.stop()

func eggshells_payout():
	if in_combo:
		if ((combo_count - COMBO_START_THRESHOLD + 2) * 5) <= 25:
			return (combo_count - COMBO_START_THRESHOLD + 2) * 5
		else:
			return 25
	else:
		return 5
