class_name PlayerController extends CharacterBody3D
# centralized place for controlling the player's movement and ui
# written by: zmopd 11/18/26

class Constants:
	static var CENTER_MOUSE: StringName = "center_mouse"
	static var GROUND_POUND: StringName = "ground_pound"
	
	static var SPEED: float = 10.0
	static var HIGH_JUMP_VELOCITY: float = 15.0
	static var REGULAR_JUMP_VELOCITY: float = 4.5
	
	static var MOUSE_SENSITIVITY: float = 0.03
	
var health: int
var collision_shape: CollisionShape3D

var meters: Dictionary[MeterProgressBar.MeterType, MeterProgressBar]

var ms_captured: bool
var ground_pound: bool
var on_high_jump: bool
var ready_to_jump: bool

var charge: float
var jump_velocity: float

func init(hitpoints: int, cs3D: CollisionShape3D):
	self.health = hitpoints
	self.collision_shape = cs3D
	
	self.ms_captured = true
	self.ground_pound = false
	self.on_high_jump = false
	self.ready_to_jump = false
	
	self.charge = 0
	self.jump_velocity = Constants.REGULAR_JUMP_VELOCITY
	
	# dependency injection (kind of)
	for node in get_tree().get_nodes_in_group("PlayerMeters"):
		if node is MeterProgressBar:
			meters[node.Type] = node

func _on_area_3d_body_entered(body: Node3D) -> void:
	if ground_pound and body.get_parent().name == "enemies":
		#print(body.name)
		body.knockback()

func input_update(deltaTime: float):
	meters[MeterProgressBar.MeterType.Health].update_bar(health)
	meters[MeterProgressBar.MeterType.Zap].update_progressive_zap(deltaTime)
	meters[MeterProgressBar.MeterType.Charge].update_progressive_charge(deltaTime)
	
	#R toggles mouse capture
	if Input.is_action_just_pressed(Constants.CENTER_MOUSE):
		ms_captured = !ms_captured
		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if (ms_captured) else Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed(Constants.GROUND_POUND) && on_high_jump:
		ground_pound = true
		on_high_jump = false

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		rotate_y(-event.screen_relative.x * Constants.MOUSE_SENSITIVITY)
		var camera_pivot = $CameraPivot

		# Rotate camera up and down
		camera_pivot.rotate_x(-event.screen_relative.y * Constants.MOUSE_SENSITIVITY)

		# Prevent camera from flipping upside down
		camera_pivot.rotation.x = clamp(
			camera_pivot.rotation.x,
				deg_to_rad(-89),
				deg_to_rad(10)
		)

func physics_control(delta: float):
	#--------------------------DEATH LOGIC----------------------------
	if position.y <= 0:
		health = 0
		
	#------------------------MOVEMENT LOGIC----------------------------
	
	#if theres a ground pound, override all phyisics
	if !ground_pound:
		#make sure scale is right
		$CollisionShape3D.scale = Vector3(1, 1, 1)
		
		# Add the gravity.ss
		if !is_on_floor():
			velocity += get_gravity() * delta

		#jump higher if jump is pressed and chargeometer is full
		if Input.is_action_pressed("ui_accept") and meters[MeterProgressBar.MeterType.Charge].value == 100:
			jump_velocity = Constants.HIGH_JUMP_VELOCITY
			ready_to_jump = true
		
		# Handle jump.
		#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#	velocity.y = JUMP_VELOCITY
		if is_on_floor() && (!Input.is_action_pressed("ui_accept") || !ready_to_jump):
			velocity.y = jump_velocity
			on_high_jump = false
			
			#if max jump, then reset chargeometer
			if ready_to_jump:
				meters[MeterProgressBar.MeterType.Charge].update_bar(0)
				SoundSystem.play_tromboing()
				on_high_jump = true
		
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay acations.
		# ^ why haven't you changed this?
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction && !(Input.is_action_pressed("ui_accept") && is_on_floor() && ready_to_jump):
			velocity.x = direction.x * Constants.SPEED
			velocity.z = direction.z * Constants.SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, Constants.SPEED)
			velocity.z = move_toward(velocity.z, 0, Constants.SPEED)
		
		# if on floor and jump cooldown is on, sets jump cooldown to false and resets jump tihng
		if is_on_floor():
			if not Input.is_action_pressed("ui_accept"):
				jump_velocity = Constants.REGULAR_JUMP_VELOCITY
				ready_to_jump = false
				
		move_and_slide()
	
	else:
		position.y -= 20 * delta
		
		if position.y <= 1.5:
			ground_pound = false
			collision_shape.scale = Vector3(1, 1, 1)
