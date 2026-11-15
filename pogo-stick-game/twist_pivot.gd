extends Node3D

@onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees.y = 0
	#print(player.name) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#center positon
	position.y = (player.position.y * -1) + 2
	
	
	#when i use arrow keys, rotate camera by 90 degrees
	#if Input.is_action_just_pressed("camera_left"):
	#	rotation_degrees.y -= 90
	#if Input.is_action_just_pressed("camera_right"):
	#	rotation_degrees.y += 90
	
	#print(rotation.y)
	
