extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pizzaria_entered.connect(enable_fog)
	SignalBus.pizzaria_exited.connect(disable_fog)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func enable_fog():
	environment.fog_enabled = true
	environment.fog_light_color = Color("#a58750")

func disable_fog():
	environment.fog_enabled = false
	environment.fog_light_color = Color("#3c4aa2")
