class_name MeterProgressBar extends TextureProgressBar

enum MeterType {
	Health,
	Charge,
	Zap
}

const CHARGE_INCREASE: float = 20
const CHARGE_DECREASE: float = 40

@export var Type: MeterType

var value_float: float = 0

func start() -> void:
	if Type == MeterType.Charge:
		value_float = 100
		print("hi")
	else:
		print("idiot")

# class methods
func update_bar(newValue: float):
	value = newValue
	value_float = newValue

func update_progressive_zap(deltaTime: float):
	value_float += 500*deltaTime;
	value = ceil(value_float)

func update_progressive_charge(increase: bool, deltaTime: float):
	if (increase):
		value_float += CHARGE_INCREASE * deltaTime
	else:
		value_float = maxf(0.0, value_float - CHARGE_DECREASE*deltaTime)
		
	value = round(value_float)
