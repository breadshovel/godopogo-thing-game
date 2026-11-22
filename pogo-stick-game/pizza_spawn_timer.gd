extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start(randf_range(2, 15)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../..".game_start and $".".is_paused():
		$".".set_paused(false)
	
	if !$"../..".game_start:
		$".".set_paused(true)
		
