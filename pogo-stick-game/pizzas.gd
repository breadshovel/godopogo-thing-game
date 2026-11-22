extends Node

const PIZZA = preload("res://pizza.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pizza_spawn_timer_timeout() -> void:
	if get_child_count() == 1:
		SpawnSystem.spawn_objects(PIZZA, 1, $".", 1.91, false)
	$PizzaSpawnTimer.start(randf_range(2, 15))
#	pizza # Replace with function body.
