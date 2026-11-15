extends TextureProgressBar

var uppy = false
var value_float := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#make go up and down waoaohoah
	if not uppy:
		value_float += 20 * delta
	elif uppy:
		pass #value_float -= 40 * delta
	
	#switch direcrion when maxed out on either side
	if value == 0:
		uppy = false
	if value == 100:
		uppy = true
	
	#round value_float into value
	value = round(value_float)
	
	#debug
	#print("VALUEVALUEVALUIE:" + str(value))
