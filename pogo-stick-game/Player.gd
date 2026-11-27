class_name Player extends Node3D

var controller
var ran_out_of_time = false
var pizza_amount = 0
var egg_shells = 0

#literally just set starting point
func _ready() -> void:
	controller = $Body
	controller.init(manage_starting_health(), $Body/Area3D/CollisionShape3D)
	position = Vector3(31.499, 1.477, 0)
	$"../enemies".all_enemies_dead.connect(heal_based_on_time_left)
	SignalBus.enemy_died.connect(enemy_kill_payout)

func _process(delta: float) -> void:
	if $"..".game_start:
		if (controller.health <= 0) or ran_out_of_time:
			if ran_out_of_time: print("ran_out_of_time was true")
			if (controller.health <= 0): print("player health was 0")
			SoundSystem.check_death_sequence(self, $"../CanvasLayer/DeathScreen", delta, $"../InGameTimer".time_left)
			return
			
	controller.input_update(delta)

func _physics_process(delta: float) -> void:
	if $"..":
		controller.physics_control(delta)

func ground_pound() -> bool:
	return controller.ground_pound
	
func take_damage(damage: float):
	controller.health -= damage

func manage_starting_health():
	if controller.health:
		return controller.health
	else:
		return 100


func _on_in_game_timer_timeout() -> void:
	ran_out_of_time = true
	print("GO HERE")
	print("timer ran out")
	
func heal_based_on_time_left():
	if $"../enemies".time_left_at_end > 10:
		extra_health_managment(($"../enemies".time_left_at_end - 10) * 2)
		SignalBus.announce("HEALTH BONUS: +" + str(int(($"../enemies".time_left_at_end - 10) * 2)) + " HEALTH", 1, Vector2(0, 0))
	
#does the math for adding health beyond a full healthbar
#written by truman 11/23/2026
func extra_health_managment(added_health):
	
	if controller.health >= 100:
		controller.health += (added_health / 2)
	
	elif (controller.health + added_health) > 100:
		var difference = (100 - controller.health)
		var extra = (added_health - difference) / 2
		
		controller.health = 100 + extra
		
	else:
		controller.health += added_health
		
	if controller.health > 200: controller.health = 200
	
func enemy_kill_payout():
	egg_shells += $"../ComboSystem".eggshells_payout()
	if $"../ComboSystem".in_combo:
		
		$"../InGameTimer".start($"../InGameTimer".time_left + 1)
	
		SignalBus.announce("COMBO " + str($"../ComboSystem".displayed_combo_count) + "\n" + 
						   "+" + str($"../ComboSystem".eggshells_payout()) + "EGG SHELLS" + "\n" +
						   "+1 TIME", 1, Vector2(randf_range(-50, 50), randf_range(-70, -10)))
		
	
	
	
	
