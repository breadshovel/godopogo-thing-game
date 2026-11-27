extends Area3D

var speed: float
var scatter: float
var despawn_ticks: float

@onready var player = $"../../Player/Body"
@onready var forward_direction = (-player.global_transform.basis.z + (Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)) * scatter)).normalized()
var tick := 0.0

var shoot_sound: AudioStream = preload("res://laserShoot.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundSystem.play_audiostream(shoot_sound, 0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#go fawrd
	position += forward_direction * delta * speed
	print(forward_direction)
	
	#increment every frame, after a while, despawn
	tick += delta
	
	if tick >= despawn_ticks:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.get_parent().name == "enemies":
		if body.health > 0:
			body.take_damage() # Replace with function body.
			queue_free()
