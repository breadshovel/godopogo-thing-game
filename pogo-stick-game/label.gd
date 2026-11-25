extends Label


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	text = str(snapped($"../../InGameTimer".time_left, 0.1) / $"../../InGameTimer".slow_down_scale)
