extends CharacterBody3D


var SPEED = randf_range(3, 15)#5.0
var speed_backup = SPEED
const JUMP_VELOCITY = 7
var jump = false
var movement_decision: Vector2
var health = 100

func _physics_process(delta: float) -> void:
	
	#if die, die
	if health <= 0:
		die()
		
	if position.y <= -5:
		die()
	
	#find player
	var player = get_tree().current_scene.find_child("Body")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump = false

	#LOOK AT PLAYER
	var temp_y = rotation_degrees.y
	var rotdegy_corrected
	look_at(player.global_position)
	
	#negative positive weirdness correction
	if temp_y >= 90 and rotation_degrees.y <= -90:
		rotdegy_corrected = rotation_degrees.y + 360
	elif rotation_degrees.y >= 90 and temp_y <= -90:
		temp_y += 360
		rotdegy_corrected = rotation_degrees.y
	else:
		rotdegy_corrected = rotation_degrees.y
		
	#make turn
	
	#slower option (semi broken):
	#rotation_degrees = Vector3(0, ((rotdegy_corrected + temp_y * 10) / 11), 0)
	
	#quicker turning (works)
	rotation_degrees = Vector3(0, rotation_degrees.y, 0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := movement_decision
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#--------------------------ATTACK & DAMAGE-------------------------------
	
	for i in range(get_slide_collision_count()):
		var collider = get_slide_collision(i).get_collider()
			
		#debug
		#print(collider.name)
		
		#if thing im colliding with is in enemy folder, take damage as player
		if collider.name == "Body":
			if not collider.ground_pound:
				collider.health -= 1
			#if randf_range(0, 10) < 1:
				#HEALTH -= 10


func _on_timer_timeout() -> void:
	jump = true # Replace with function body.
	$Timer.wait_time = randf_range(0, 3)
	
	#reset speed if got ground pounded
	SPEED = speed_backup
	
	#decide which direction enemy is going in
	var i = randf_range(0, 10)
	if i < 1:
		movement_decision = Vector2(1, 0)
	elif i < 2:
		movement_decision = Vector2(-1, 0)
	elif i < 2.5:
		movement_decision = Vector2(0, 1)
	else:
		movement_decision = Vector2(0, -1)
		

func take_damage() -> void:
	health -= 25

func die() -> void:
	queue_free() # Replace with function body.
	
func knockback() -> void:
	health -= 50
	movement_decision = Vector2(0, 1)
	$Timer.start(3)
	SPEED = 20
