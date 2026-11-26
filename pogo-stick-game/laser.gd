extends Area3D

const SPEED = 45

@onready var player = $"../../Player/Body"
@onready var forward_direction = -player.global_transform.basis.z.normalized()
var tick := 0.0

var shoot_sound: AudioStream = preload("res://laserShoot.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundSystem.play_audiostream(shoot_sound, 0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#go fawrd
	position += forward_direction * delta * SPEED
	
	#increment every frame, after a while, despawn
	tick += delta
	
	if tick >= 10000:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.get_parent().name == "enemies":
		body.take_damage() # Replace with function body.
		queue_free()
