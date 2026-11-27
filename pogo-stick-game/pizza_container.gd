extends Sprite2D

const EMPTY = preload("res://Textures/pizza container.png")
const FULL = preload("res://Textures/pizza container full.png")

@onready var player = $"../../Player"
@onready var counter = $"../PizzaAmount"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.pizza_amount > 0:
		texture = FULL
		counter.visible = true
		counter.text = str(player.pizza_amount)
	else:
		texture = EMPTY
		counter.visible = false
		
