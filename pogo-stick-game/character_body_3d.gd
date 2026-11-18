extends CharacterBody3D


const high_jump := 15.0#10
const SPEED := 10.0
var HEALTH := 100.0

@onready var JUMP_VELOCITY = 4.5
@onready var GROUND_Y := position.y
@onready var ready_to_jump := false
@onready var progress_bar := $"../CanvasLayer/Chargeometer"
@onready var value = progress_bar.value
@onready var ground_pound := false
@onready var on_high_jump := false
@onready var delta_y_but_it_works := 0.0

var mouse_capture_toggle := true

var delta_x := 0.0
var delta_y := 0.0

#literally just set starting point
func _ready() -> void:
	start()

func start() -> void:
	HEALTH = 100.0
	JUMP_VELOCITY = 4.5
	GROUND_Y = position.y
	ready_to_jump = false
	progress_bar = $"../CanvasLayer/Chargeometer"
	value = progress_bar.value
	ground_pound = false
	on_high_jump = false
	delta_y_but_it_works = 0.0
	mouse_capture_toggle = true
	delta_x = 0.0
	delta_y = 0.0
	position = Vector3(31.499, 1.477, 0)


func _physics_process(delta: float) -> void:
	
	if $"..".game_start:
	
		#get value from chargeometer
		value = progress_bar.value
		
		
		#--------------------------DEATH LOGIC----------------------------
		
		if position.y <= 0:
			HEALTH = 0
		
		
		
		#----------------------MOUSE CAPTURE LOGIC------------------------
		
		#R toggles mouse capture
		if Input.is_action_just_pressed("center_mouse"):
			mouse_capture_toggle = !mouse_capture_toggle
		
		#mouse capture if mouse capture toggle
		if mouse_capture_toggle:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			
			
		#------------------------------CAMERA CONTROLa-------------------------------
		
		#BUTTON INPUT:
		#if Input.is_action_pressed("camera_left"):
		#	rotation_degrees.y += 90  * delta
		#if Input.is_action_pressed("camera_right"):
		#	rotation_degrees.y -= 90 * delta
		
		#MOUSE INPUT:
		rotation_degrees.y -= delta_x
		delta_y_but_it_works = delta_y
		delta_x = 0
		delta_y = 0
		
		#DONT NEED ANYMORE, now area 3d deals with ground pounds
		#$CollisionShape3D.scale = Vector3(3, 3, 3)
		
		
		#------------------------MOVEMENT LOGIC----------------------------
		
		#if in a big jump and ground pound button pressed; initiate ground pound
		if Input.is_action_just_pressed("ground_pound") and on_high_jump:
			ground_pound = true
			on_high_jump = false
		
		#if theres a ground pound, override all phyisics
		if !ground_pound:
			
			#make sure scale is right
			$CollisionShape3D.scale = Vector3(1, 1, 1)
			
			# Add the gravity.
			if not is_on_floor():
				velocity += get_gravity() * delta

			#jump higher if jump is pressed and chargeometer is full
			if Input.is_action_pressed("ui_accept") and value == 100:
				JUMP_VELOCITY = high_jump
				ready_to_jump = true
			
			# Handle jump.
			#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			#	velocity.y = JUMP_VELOCITY
			if is_on_floor() and (not Input.is_action_pressed("ui_accept") or not ready_to_jump):
				velocity.y = JUMP_VELOCITY
				GROUND_Y = position.x
				on_high_jump = false
				
				#if max jump, then reset chargeometer
				if ready_to_jump:
					$"../CanvasLayer/Chargeometer".value_float = 0
					on_high_jump = true
			
			
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay acations.
			var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction and not (Input.is_action_pressed("ui_accept") and is_on_floor() and ready_to_jump):
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
					
			
			#debug
			#print(JUMP_VELOCITY)
			#print("hi" + str(value))
			move_and_slide()
		
		else:
			position.y -= 20 * delta
			
			if position.y <= 1.5:
				ground_pound = false
				$CollisionShape3D.scale = Vector3(1, 1, 1)
		#--------------------------DAMAGE & STUFF-------------------------
		
		#for i in range(get_slide_collision_count()):
			#var collider = get_slide_collision(i).get_collider()
			
			#debug
			#print(collider.name)
			
			#if thing im colliding with is in enemy folder, take damage as player
			#if collider.get_parent().name == "enemies":
			#	if randf_range(0, 10) < 1:
			#		HEALTH -= 10
		
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		delta_x = event.relative.x
		delta_y = event.relative.y
		#print(delta_y)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if ground_pound and body.get_parent().name == "enemies":
		#print(body.name)
		body.knockback() # Replace with function body.
