extends Node

var BUSH = preload("res://bush.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpawnSystem.spawn_objects(BUSH, 101, $".", .433, true, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
