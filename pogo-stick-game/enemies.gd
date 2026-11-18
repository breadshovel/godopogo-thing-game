extends Node

const enemy_scene = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_enemy = enemy_scene.instantiate() # Replace with function body.
	new_enemy.global_position = Vector3(25, 10, 0)
	add_child(new_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func spawn_enemy
