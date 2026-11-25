extends Node

var game = null
var pizzaria_interior = null
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = preload("res://node_3d.tscn").instantiate()
	add_child(game)
	SignalBus.pizzaria_entered.connect(load_pizzaria)
	
	current_scene = game

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_pizzaria():
	game.process_mode = PROCESS_MODE_DISABLED
	game.visible = false
	
	pizzaria_interior = preload("res://interior.tscn").instantiate()
	add_child(pizzaria_interior)

	current_scene = pizzaria_interior
