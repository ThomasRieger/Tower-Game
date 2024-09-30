extends Node2D
signal dash_ready_signal

@onready var timer = $dashtimer
var dash_ready = false

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player" && visible:
		dash_ready = true
		visible = false
		emit_signal("dash_ready_signal")
		
func start_dash(dur):
	timer.wait_time = dur
	timer.start()
	dash_ready = false
	
func is_dashing():
	return timer.is_stopped() == false
