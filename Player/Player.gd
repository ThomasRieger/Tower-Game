extends CharacterBody2D

# Constant
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 500.0
const FALL_MULTIPLIER = 1.5
const DASH_SPEED = 700.0
const POWTIME = 0.1

# Nodes
@onready var colli = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var leftray = $left_ray
@onready var rightray = $right_ray
@export var sfx_walk : AudioStream
@export var sfx_jump : AudioStream
@export var sfx_wallJump : AudioStream
@export var sfx_dash : AudioStream
var footstep_frame : Array = [0,3]

# Variable
var facing_direction = 0 
var animation_lock : bool = false
var is_wall_sliding = false
var wall_sliding_gravity = 100.0
var jump_num = 2

func _physics_process(delta: float) -> void:
# Wall jump.
	if Input.is_action_pressed("jump") and is_on_wall() and Engine.time_scale != 0:
		wall_jump()
# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and Engine.time_scale != 0:
		jump()
		jump_num = 1
	elif is_on_floor():
		jump_num = 2
	
# Jump control
	if Input.is_action_just_released("jump") and Engine.time_scale != 0:
		jump_cut()

# ------------------- Dash Powerup -----------------------------#

# Dash
	if global.dash:
		if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("dash")) and jump_num == 1 and !is_on_floor():
			if global.is_dash == false and jump_num == 1:
				play_sfx(sfx_dash)
				$ParticlesDash.emitting = true
				global.is_dash = true
		else:
			global.is_dash = false

# DoubleJump
	if global.double_jump:
		if Input.is_action_just_pressed("jump") and !is_on_floor() and jump_num >= 1 and Engine.time_scale != 0:
			jump()
			jump_num = 0
	movement(delta)

# ------------------- Function in use -------------------------#

	move_and_slide()
	wall_slide(delta)
	gravity(delta)

#--------------------------Functions--------------------------#

# Jump
func jump():
	$ParticlesJump.emitting = true
	play_sfx(sfx_jump)
	if global.speed_boost > 1:
		velocity.y = JUMP_VELOCITY * 1.5
	else:
		velocity.y = JUMP_VELOCITY
	wall_jump()
# Short jump
func jump_cut():
	if velocity.y < -50:
		velocity.y = -50
# Wall jump
func wall_jump():
	if is_on_wall() and global.wall_jump:
		play_sfx(sfx_wallJump)
	if is_on_wall() and leftray.is_colliding() and global.wall_jump:
		velocity.y = JUMP_VELOCITY
		# left
		velocity.x = 180
		#print(norm)
		#print(velocity)
	elif is_on_wall() and rightray.is_colliding() and global.wall_jump:

		velocity.y = JUMP_VELOCITY
		# right
		velocity.x = -180
		#print(velocity)
# Walk animation
func walk_animation():
	if abs(velocity.x) > 0 and sprite.animation != "Walk_loop" and abs(velocity.y) < 2:
		sprite.play("Walk_loop")
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
		sprite.play("downdown")
		velocity.y += wall_sliding_gravity * delta
		velocity.y = min(velocity.y, wall_sliding_gravity)
	# Particle
	if leftray.is_colliding() and is_wall_sliding:
		$ParticlesWallSlide_L.emitting = true
	elif rightray.is_colliding() and is_wall_sliding:
		$ParticlesWallSlide_R.emitting = true
	else:
		$ParticlesWallSlide_L.emitting = false
		$ParticlesWallSlide_R.emitting = false		
# Gravity
func gravity(delta):
	if not is_on_floor():
		if velocity.y > 0:  # If falling
			velocity.y += GRAVITY * FALL_MULTIPLIER * delta
			# max falling speed
			velocity.y = min(velocity.y, 500)
		else:  # If jumping up
			velocity.y += GRAVITY * delta
# Movement
func movement(delta):
	var direction := Input.get_axis("a", "d")
	
	if sprite.flip_h and global.is_dash and !leftray.is_colliding() and jump_num >= 1:
		jump_num -= 1
		velocity.x = -DASH_SPEED * global.speed_boost
		velocity.y -= 100
		global.is_dash = false
		#print(global.dash)
	elif !sprite.flip_h and global.is_dash and !rightray.is_colliding() and jump_num >= 1:
		jump_num -= 1
		velocity.x = DASH_SPEED * global.speed_boost
		velocity.y -= 100
		global.is_dash = false
	walk_animation()
	if velocity.x != 0 and is_on_floor():
		$ParticlesMove.emitting = true
	if direction != 0 and abs(velocity.x) < SPEED * global.speed_boost:
		velocity.x += direction * SPEED * delta * 10 * global.speed_boost
		if direction == -1 and Engine.time_scale != 0:
			sprite.flip_h = true
		elif direction == 1 and Engine.time_scale != 0:
			sprite.flip_h = false
	else:
		#if global.dash:
			#var face = facing_direction
			#velocity.x = face * DASH_SPEED
		#else:
		velocity.x = move_toward(velocity.x, 0, (delta * abs(velocity.x) * 1.4) + 7)
		$ParticlesMove.emitting = false
		#velocity.x = move_toward(velocity.x, 0, delta * abs(velocity.x) * 100)
	if abs(velocity.x) < 2 and velocity.y == 0:
		sprite.play("Idle")
		#print(velocity.x)
	elif abs(velocity.y) < 1 and direction == 0:
		sprite.play("Stoping")
	elif velocity.y < -80:
		sprite.play("upup")
	#elif velocity.y < -20:
		#sprite.play("up")
	elif velocity.y > 80:
		sprite.play("downdown")
		#print(velocity.y)
	#elif velocity.y > 20:
		#sprite.play("down")
#print(sprite.animation)

#--------------------------Sounds--------------------------#
func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load
		
func play_sfx(sfx_to_play):
	load_sfx(sfx_to_play)
	%sfx_player.play()

func _on_animated_sprite_2d_frame_changed() -> void:
	if sprite.animation == "Idle": return
	if sprite.animation == "Stopping": return
	if sprite.animation == "upup": return
	if sprite.animation == "downdown": return
	load_sfx(sfx_walk)
	if sprite.frame in footstep_frame and velocity.x != 0 and is_on_floor():
		%sfx_player.play()
		
