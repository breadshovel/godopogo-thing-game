extends Node

const LASER = preload("res://laser.tscn")


@onready var player = $"../Player/Body"
@onready var zapometer = $"../CanvasLayer/Meters/Zapometer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.shoot.connect(shoot_bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func shoot_bullet(plr, bullet_speed, bullet_amount, scatter, despawn_ticks):
	
	for i in range(bullet_amount):
		var new_laser = LASER.instantiate()
		new_laser.position = plr.global_position
		new_laser.rotation_degrees.y = player.rotation_degrees.y + 90
		new_laser.visible = true
		new_laser.position.y += 0
				
		new_laser.player = plr
		new_laser.speed = bullet_speed
		new_laser.scatter = scatter
		new_laser.despawn_ticks = despawn_ticks
				
		var forward_direction = -player.global_transform.basis.z.normalized()
		new_laser.position += forward_direction * .5
				
		add_child(new_laser)
				
		zapometer.value_float = 0
