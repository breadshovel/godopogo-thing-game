extends Timer

@onready var enemies = $"../enemies"
var slow_down_scale = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pizzaria_entered.connect(slow_down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(time_left * slow_down_scale)


func _on_start_game_timer_timeout() -> void:
	start(30)


func _on_enemies_all_enemies_dead() -> void:
	stop() # Replace with function body.

func slow_down():
	slow_down_scale *= 10
	start(time_left*10)
