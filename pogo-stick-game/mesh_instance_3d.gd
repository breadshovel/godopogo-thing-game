extends MeshInstance3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bush_clone = self.duplicate() # Replace with function body.

	bush_clone.position = Vector3(0,0,0)
	
	add_sibling.call_deferred(bush_clone)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
