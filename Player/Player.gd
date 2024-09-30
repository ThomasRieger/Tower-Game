extends CharacterBody2D

# Constant
const SPEED = 50.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 500.0
const FALL_MULTIPLIER = 1.5
const DASH_SPEED = 300.0
const DASH_LENGHT = 0.1

# Nodes
@onready var colli = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var leftray = $left_ray
@onready var rightray= $right_ray

@onready var Powerup_Dash = $"../Pickups/Dash_pickup"

# Variable
var facing_direction = 0 
var dash_timer = 0.0
var animation_lock : bool = false
var is_wall_sliding = false
var wall_sliding_gravity = 100.0

#Powerups

func Dash(delta):
	if Powerup_Dash.dash_ready:
		if dash_timer > 0:
			dash_timer -= delta  # Reduce timer 
		else:# Dash
			if Input.is_action_just_pressed("dash") and not Powerup_Dash.is_dashing():
				Powerup_Dash.start_dash(DASH_LENGHT)
				dash_timer = 2.0
	if is_on_floor(): dash_timer = 0.0

func _physics_process(delta: float) -> void:
# Wall jump.
	if Input.is_action_pressed("jump") and is_on_wall():
		wall_jump()
# Jump
	if Input.is_action_pressed("jump") and is_on_floor():
		jump()
# Jump control
	if Input.is_action_just_released("jump"):
		jump_cut()

# Dash movement
	var effective_speed = DASH_SPEED if Powerup_Dash.is_dashing() else SPEED

# Function in use
	Dash(delta)
	movement(effective_speed,SPEED,delta)
	move_and_slide()
	wall_slide(delta)
	gravity(GRAVITY,FALL_MULTIPLIER,delta)

#--------------------------Functions--------------------------#
# Jump
func jump():
	velocity.y = JUMP_VELOCITY
	wall_jump()
# Short jump
func jump_cut():
	if velocity.y < -50:
		velocity.y = -50
# Wall jump
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
# Walk animation
func walk_animation():
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
# Wall Slide
func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if leftray.is_colliding() or rightray.is_colliding():
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	if is_wall_sliding:
		velocity.y += wall_sliding_gravity * delta
		velocity.y = min(velocity.y, wall_sliding_gravity)
# Gravity
func gravity(gra,fallgra,delta):
	if not is_on_floor():
		if velocity.y > 0:  # If falling
			velocity.y += gra * fallgra * delta
			# max falling speed
			velocity.y = min(velocity.y, 500)
		else:  # If jumping up
			velocity.y += gra * delta
# Movement
func movement(effective_speed,spd,delta):
	var direction := Input.get_axis("a", "d")
	if direction != 0:
		velocity.x += direction * spd * delta *10
		
		#print(velocity.x)
		facing_direction = direction
		if facing_direction == -1:
			sprite.flip_h = true
			if Powerup_Dash.is_dashing():
				velocity.x = -effective_speed
			else:
				velocity.x = max(velocity.x , -200)
		else:
			sprite.flip_h = false
			if Powerup_Dash.is_dashing():
				velocity.x = effective_speed
			else:
				velocity.x = min(velocity.x , 200)
		walk_animation()
		
	else:
		if Powerup_Dash.is_dashing():
			var face = facing_direction
			velocity.x = face * DASH_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, spd * delta * 10)
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
