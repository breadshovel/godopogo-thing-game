extends Camera3D

#@onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#print(player.name) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	pass
#BUTTON INPUT:
#	if Input.is_action_pressed("camera_up"):
#		rotation_degrees.x = 23
#		position.y = -2
#	else:
#		rotation_degrees.x = -23
#		position.y = 0

#MOUSE INPUT:
#	rotation_degrees.x -= $"../../..".delta_y

		#position.y = (player.position.y * -1) + 4
	#print(position.y)
