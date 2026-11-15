extends CharacterBody3D


const SPEED = 5.0
@onready var JUMP_VELOCITY = 4.5
@onready var GROUND_Y := position.y
@onready var ready_to_jump := false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#jump higher if jump is pressed
	if Input.is_action_just_pressed("ui_accept"):
		JUMP_VELOCITY = 7
		ready_to_jump = true
	
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	if is_on_floor() and not Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		GROUND_Y = position.x
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay acations.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and not (Input.is_action_pressed("ui_accept") and is_on_floor()):
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#if on floor and jump cooldown is on, sets jump cooldown to false and resets jump tihng
	if is_on_floor():
		if not Input.is_action_pressed("ui_accept"):
			JUMP_VELOCITY = 4.5
			ready_to_jump = false
		
	#CAMERA CONTROLa
	if Input.is_action_pressed("camera_left"):
		rotation_degrees.y += 90  * delta
	if Input.is_action_pressed("camera_right"):
		rotation_degrees.y -= 90 * delta
	
	
	#debug
	print(JUMP_VELOCITY)
	
	move_and_slide()
