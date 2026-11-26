extends Sprite2D

var pause1 = load("res://Textures/paused1.png")
var pause2 = load("res://Textures/paused2.png")

@onready var NodeParent = $"."
@onready var pause_screen: Sprite2D = $CanvasLayer/PauseScreen

func _on_pause_timer_timeout() -> void:
	if texture.resource_path == "res://Textures/paused1.png":
		texture = pause2
	else:
		texture = pause1

#------------PAUSE CONTROLLER------------------------------

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
		$"../Controls".visible = get_tree().paused
