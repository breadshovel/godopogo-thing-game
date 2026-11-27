extends Node3D

signal pizzaria_entered
signal pizzaria_exited
signal announcer_signal
signal enemy_died
signal combo_started
signal combo_ended
signal shoot

var player_teleport_position

func announce(message, time, position):
	announcer_signal.emit(message, time, position)
