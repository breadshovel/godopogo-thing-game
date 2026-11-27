class_name PlayerController extends CharacterBody3D
# centralized place for controlling the player's movement and ui
# written by: zmopd 11/18/26

class Constants:
	#sound
	static var TROMBOING: AudioStream = preload("res://Sounds/07 Tromboing.mp3")
	static var THUNK: AudioStream = preload("res://Sounds/83 Thunk.mp3")
	
	# velocity
	static var SPEED: float = 15.0
	static var HIGH_JUMP_VELOCITY: float = 15.0
	static var REGULAR_JUMP_VELOCITY: float = 4.5
	# input
	static var CENTER_MOUSE: StringName = "center_mouse"
	static var GROUND_POUND: StringName = "ground_pound"
	static var MOUSE_SENSITIVITY: float = 0.001
	static var CHARGE_HOLD_THRESHOLD: float = 0.0
	
var health: int
var collision_shape: CollisionShape3D

var meters: Dictionary[MeterProgressBar.MeterType, MeterProgressBar]

var ms_captured: bool
var ground_pound: bool
var on_high_jump: bool
var ready_to_jump: bool

var charge: float
var jump_velocity: float
var extra_health_bar
var extra_health: float
var reload_speed: float
var bullet_amount
var bullet_speed
var scatter
var bullet_despawn_ticks

@onready var plr = $".."

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
			
	set_gun_pistol()

var space_hold: float = 0.0
func input_update(deltaTime: float):
	meters[MeterProgressBar.MeterType.Health].update_bar(health)
	meters[MeterProgressBar.MeterType.Zap].update_progressive_zap(reload_speed, deltaTime)

	extra_health_bar = $"../../CanvasLayer/Meters/PlayerExtraHealthBar"
	
	if health > 100:
		extra_health = health - 100
		
		extra_health_bar.visible = true
		extra_health_bar.update_bar(extra_health)
	else:
		extra_health_bar.visible = false
		
	if space_hold >= Constants.CHARGE_HOLD_THRESHOLD && Input.is_action_pressed("ui_accept"):
		meters[MeterProgressBar.MeterType.Charge].update_progressive_charge(true, deltaTime)
		space_hold = 0
	elif Input.is_action_just_pressed("ui_accept"):
		space_hold += deltaTime
	else:
		space_hold = 0
		meters[MeterProgressBar.MeterType.Charge].update_progressive_charge(true, deltaTime)
	
	#R toggles mouse capture
	if Input.is_action_just_pressed(Constants.CENTER_MOUSE):
		ms_captured = !ms_captured
		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if (ms_captured) else Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed(Constants.GROUND_POUND) && on_high_jump:
		ground_pound = true
		on_high_jump = false
		SoundSystem.play_audiostream(Constants.THUNK, 0.28)
		
	if Input.is_action_just_pressed("shoot") and $"../../CanvasLayer/Meters/Zapometer".value >= 100 and $"../..".game_start:
		SignalBus.shoot.emit(self, bullet_speed, bullet_amount, scatter, bullet_despawn_ticks)

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
		
	#------------------IF RIGHT CLICK USE A PIZZA I GUESS-------------
	pizza_healing()
	
	
	
	#------------------------MOVEMENT LOGIC----------------------------
	
	#if theres a ground pound, override all phyisics
	if !ground_pound:
		#make sure scale is right
		#$CollisionShape3D.scale = Vector3(1, 1, 1)
		
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
				SoundSystem.play_audiostream(Constants.TROMBOING, 0, randf_range(0.75, 2))
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
			#collision_shape.scale = Vector3(1, 1, 1)


func _on_groundpoundcollision_body_entered(body: Node3D) -> void:
	if ground_pound and body.get_parent().name == "enemies":
		#print(body.name)
		body.knockback()
		
func pizza_healing():
	if Input.is_action_just_pressed("heal") and plr.pizza_amount > 0:
		plr.extra_health_managment(75)
		plr.pizza_amount -= 1

func set_gun_pistol():
	reload_speed = 500
	bullet_amount = 1
	bullet_speed = 45
	scatter = 0
	bullet_despawn_ticks = 1
	
func set_gun_shotgun():
	reload_speed = 50
	bullet_amount = 45
	bullet_speed = 90
	scatter = .3
	bullet_despawn_ticks = .25
