extends MeshInstance3D

var player: CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.y = player.global_position.y * -1 + 0.5
	visible = player.ready_to_jump
