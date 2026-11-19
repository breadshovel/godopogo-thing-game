class_name MeterProgressBar extends TextureProgressBar

enum MeterType {
	Health,
	Charge,
	Zap
}

@export var Type: MeterType

var uppy: bool = false
var value_float: float = 0

func _init():
	pass

# class methods
func update_bar(newValue: float):
	value = newValue
	value_float = newValue

func update_progressive_zap(deltaTime: float):
	value_float += 500*deltaTime;
	value = ceil(value_float)

func update_progressive_charge(deltaTime: float):
	if not uppy:
		value_float += 20 * deltaTime
	
	#switch direcrion when maxed out on either side
	
	#round value_float into value
	value = round(value_float)
