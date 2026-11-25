extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pizzaria_entered.connect(enable_fog)
	SignalBus.pizzaria_exited.connect(enable_fog)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func enable_fog():
	environment.fog_light_color = Color("#a58750")
