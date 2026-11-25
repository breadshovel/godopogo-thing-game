extends StaticBody3D

signal pizzaria_entered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation.y = randf_range(-360, 360) # Replace with function body.
	$DespawnTimer.start(20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_despawn_timer_timeout() -> void:
	queue_free() # Replace with function body.


func _on_pizzaria_body_entered(body: Node3D) -> void:
	if body.get_parent().name == "Player":
		body.global_position = Vector3(146.458, 30.2, 50)
		SignalBus.pizzaria_entered.emit()
		SignalBus.player_teleport_position = Vector3(global_position.x, global_position.y + 10, global_position.z)
