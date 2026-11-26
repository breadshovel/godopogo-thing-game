extends StaticBody3D

const PIZZA = preload("res://pizza.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pizzaria_entered.connect(spawn_pizza)

func spawn_pizza():
	var pizza_object = PIZZA.instantiate()
	add_child(pizza_object)
	pizza_object.position = Vector3(18.651, 7.177, 48.098)
	pizza_object.rotation = Vector3(0, 60, 0)
