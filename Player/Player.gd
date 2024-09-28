extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0
const GRAVITY = 500.0
const FALL_MULTIPLIER = 1.5
const DASH_SPEED = 400.0
const DASH_LENGHT = 0.1

@onready var dash = $Dash

var facing_direction = 0 
var dash_timer = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:  # If falling
			velocity.y += GRAVITY * FALL_MULTIPLIER * delta
			# max falling speed
			velocity.y = min(velocity.y, 500)
		else:  # If jumping up
			velocity.y += GRAVITY * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		
	# Jump control
	if Input.is_action_just_released("jump"):
		jump_cut()
		
		# Dash
	if dash_timer > 0:
		dash_timer -= delta  # Reduce timer 
	else:
		# Dash
		if Input.is_action_just_pressed("dash") and not dash.is_dashing():
			dash.start_dash(DASH_LENGHT)
			dash_timer = 2.0
	var effective_speed = DASH_SPEED if dash.is_dashing() else SPEED
	if is_on_floor(): dash_timer = 0.0
	
	# movement
	var direction := Input.get_axis("a", "d")
	if direction != 0:
		velocity.x = direction * effective_speed
		facing_direction = direction
	else:
		if dash.is_dashing():
			var face = facing_direction
			velocity.x = face * DASH_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, effective_speed)
	
	move_and_slide()
	
func jump():
	velocity.y = JUMP_VELOCITY
	
func jump_cut():
	if velocity.y < -50:
		velocity.y = -50
