extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#MOUSE INPUT:
	rotation_degrees.x -= $"../..".delta_y
	
	#clamp so it cant spin forever
	if rotation_degrees.x >= 11:
		rotation_degrees.x = 11
	if rotation_degrees.x <= -90:
		rotation_degrees.x = -90
	
	#debug
	#print(rotation_degrees.x)
