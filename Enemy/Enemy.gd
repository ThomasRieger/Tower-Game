extends CharacterBody2D


var speed = -60.0

func _ready() -> void:
	$AnimationPlayer.play("Run")

var facing_right = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor() or is_on_wall():
		flip()

		
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		global.dash = false
		global.is_dash = false
		global.double_jump = false
		global.speed_boost = 1
		global.wall_jump = false
		global.power_dur = 10
		global.power_time = [0, 0, 0, 0]
		get_parent().get_parent().get_node("Player").visible = false
		await get_tree().create_timer(0.001).timeout
		SceneTransition.change_scene("res://main/Start_floor_1.tscn")
