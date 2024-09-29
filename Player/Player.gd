extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 500.0
const FALL_MULTIPLIER = 1.5
const DASH_SPEED = 300.0
const DASH_LENGHT = 0.1

@onready var dash = $Dash
@onready var colli = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var leftray = $left_ray
@onready var rightray= $right_ray

var facing_direction = 0 
var dash_timer = 0.0
var animation_lock : bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:  # If falling
			velocity.y += GRAVITY * FALL_MULTIPLIER * delta
			# max falling speed
			velocity.y = min(velocity.y, 500)
		else:  # If jumping up
			velocity.y += GRAVITY * delta
			
	# Wall jump
	if Input.is_action_pressed("jump") and is_on_wall():
		wall_jump()
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
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
		velocity.x += direction * SPEED * delta *10
		
		#print(velocity.x)
		facing_direction = direction
		if facing_direction == -1:
			sprite.flip_h = true
			if dash.is_dashing():
				velocity.x = -effective_speed
			else:
				velocity.x = max(velocity.x , -200)
		else:
			sprite.flip_h = false
			if dash.is_dashing():
				velocity.x = effective_speed
			else:
				velocity.x = min(velocity.x , 200)
		walk()
		
	else:
		if dash.is_dashing():
			var face = facing_direction
			velocity.x = face * DASH_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta * 10)
			if velocity.x != 0 and abs(velocity.y) < 20:
				sprite.play("Stoping")
			elif velocity.y < -80:
				sprite.play("upup")
			#elif velocity.y < -20:
				#sprite.play("up")
			elif velocity.y > 80:
				sprite.play("downdown")
			#elif velocity.y > 20:
				#sprite.play("down")
			else:
				sprite.play("Idle")
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	wall_jump()

func jump_cut():
	if velocity.y < -50:
		velocity.y = -50
		
func wall_jump():
	if is_on_wall() and leftray.is_colliding():
		velocity.y = JUMP_VELOCITY
		# left
		velocity.x = 150
		#print(norm)
		#print(velocity)
	elif is_on_wall() and rightray.is_colliding():
		velocity.y = JUMP_VELOCITY
		# right
		velocity.x = -150
		#print(velocity)
		
func walk():
	if abs(velocity.y) < 10:
		sprite.play("Walk_loop")
	elif velocity.y < -80:
		sprite.play("upup")
	#elif velocity.y < -20:
		#sprite.play("up")
	elif velocity.y > 80:
		sprite.play("downdown")
	#elif velocity.y > 20:
		#sprite.play("down")
	animation_lock = true
