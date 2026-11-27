extends StaticBody3D

const PIZZA = preload("res://pizza.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pizzaria_entered.connect(initiate_room)

func initiate_room():
	var pizza_object = PIZZA.instantiate()
	add_child(pizza_object)
	pizza_object.position = Vector3(18.651, 7.177, 48.098)
	pizza_object.rotation = Vector3(0, 60, 0)
	$"Platform 1".position.z = randf_range(47, 53)
	$"Platform 2".position.z = randf_range(47, 53)
