class_name Player extends Node3D

var controller: PlayerController

#literally just set starting point
func _ready() -> void:
	controller = $Body
	controller.init(manage_starting_health(), $Body/Area3D/CollisionShape3D)
	position = Vector3(31.499, 1.477, 0)

func _process(delta: float) -> void:
	if $"..".game_start:
		if (controller.health <= 0):
			SoundSystem.check_death_sequence(self, $"../CanvasLayer/DeathScreen", delta)
			return
			
	controller.input_update(delta)

func _physics_process(delta: float) -> void:
	if $"..":
		controller.physics_control(delta)

func ground_pound() -> bool:
	return controller.ground_pound
	
func take_damage(damage: float):
	controller.health -= damage

func manage_starting_health():
	if controller.health:
		return controller.health
	else:
		return 100
