extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn 100 mopre bushes at random positons on the map
	for i in range(100):
		var bush_clone = $MeshInstance3D.duplicate() # Replace with function body.

		bush_clone.position = Vector3(randf_range(-12.324, 89.245),.433,randf_range(-59.235, 59.167))
	
		add_sibling.call_deferred(bush_clone)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
