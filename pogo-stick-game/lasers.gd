extends Node

@onready var player = $"../Player/Body"
@onready var zapometer = $"../CanvasLayer/Zapometer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if shoot pressed, copy laser, make visible, make go forward until BLANK
		if Input.is_action_just_pressed("shoot") and zapometer.value >= 100 and $"..".game_start:
			var new_laser = $laser.duplicate()
			new_laser.position = player.global_position
			new_laser.rotation_degrees.y = player.rotation_degrees.y + 90
			new_laser.visible = true
			new_laser.position.y += 5.5
			
			var forward_direction = -player.global_transform.basis.z.normalized()
			new_laser.position += forward_direction * 1
			
			add_child(new_laser)
			
			zapometer.value_float = 0
