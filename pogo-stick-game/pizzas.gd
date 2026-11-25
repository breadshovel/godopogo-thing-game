extends Node

const PIZZA = preload("res://pizza.tscn")
const PIZZARIA = preload("res://pizzaria.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pizza_spawn_timer_timeout() -> void:
	if get_child_count() == 1:
		SpawnSystem.spawn_objects(PIZZARIA, 1, $".", 0, false, $"../Player/Body".position)
	$PizzaSpawnTimer.start_pizza_timer()
#	pizza # Replace with function body.
