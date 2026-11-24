extends Timer

@onready var enemies = $"../enemies"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(time_left)


func _on_start_game_timer_timeout() -> void:
	start(30)


func _on_enemies_all_enemies_dead() -> void:
	stop() # Replace with function body.
