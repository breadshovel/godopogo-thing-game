extends Node3D

signal pizzaria_entered
signal pizzaria_exited
signal announcer_signal

var player_teleport_position

func announce(message, time):
	announcer_signal.emit(message, time)
