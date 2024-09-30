extends Node2D

@onready var timer = $dashtimer
@onready var dash_ready = false

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player" && visible:
		dash_ready = true
		visible = false
		
func start_dash(dur):
	timer.wait_time = dur
	timer.start()
	
func is_dashing():
	return timer.is_stopped() == false
