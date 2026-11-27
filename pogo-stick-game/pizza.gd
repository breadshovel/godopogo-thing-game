extends Area3D

const DESPAWN_LENGTH := 20

#spawn in 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#$DespawnTimer.start(DESPAWN_LENGTH) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.get_parent().name == "Player":
		var plr = body.get_parent()
		#plr.extra_health_managment(75)
		plr.pizza_amount += 3
		queue_free()
		
##does the math for adding health beyond a full healthbar
##written by truman 11/23/2026
#func extra_health_managment(body, added_health):
	#
	#if body.health >= 100:
		#body.health += (added_health / 2)
	#
	#elif (body.health + added_health) > 100:
		#var difference = (100 - body.health)
		#var extra = (added_health - difference) / 2
		#
		#body.health = 100 + extra
		#
	#else:
		#body.health += added_health
		#
	#if body.health > 200: body.health = 200

func _on_despawn_timer_timeout() -> void:
	queue_free()
