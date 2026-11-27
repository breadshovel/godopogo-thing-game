extends Node

const ANNOUNCER = preload("res://announcer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.announcer_signal.connect(create_announcer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_announcer(message, time, label_pos):
	var announcer = ANNOUNCER.instantiate()
	add_child(announcer)
	announcer.position = label_pos
	announcer.announce(message, time)
	#pass
