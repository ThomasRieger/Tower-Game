extends Node2D

@onready var sprite : AnimatedSprite2D = $"../AnimatedSprite2D"
@export var default_direction = Vector2.RIGHT
var bullet = preload("res://Player/Gun/bullet.tscn") 
var can_shoot = true
var Cooldown = 0.0
func _ready() -> void:
	self.z_index = 10

func _process(delta: float) -> void:
	var cursor_position = get_global_mouse_position()
	#var direction_to_cursor = global_position.direction_to(cursor_position)
	var rotate_angle = global_position.angle_to_point(cursor_position)
	rotation = rotate_angle
	
	if not can_shoot:
		Cooldown += delta
		if Cooldown >= 0.4:
			can_shoot = true
			Cooldown = 0.0
		
	if Input.is_action_just_pressed("fire") and can_shoot and Engine.time_scale != 0:
		fire()
		AudioController.sfx_fire()
		can_shoot = false
		
func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.rotation = rotation
	get_parent().add_child(bullet_instance)
	
