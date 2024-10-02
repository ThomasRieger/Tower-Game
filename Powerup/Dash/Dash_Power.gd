extends Node2D
signal dash_ready_signal

var dash_ready = false
@onready var timer = $Timer
@onready var dashtimer = $dashtimer

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player" && visible:
		dash_ready = true
		visible = false
		emit_signal("dash_ready_signal")
		timer.start(10)

func _physics_process(delta: float) -> void:
	if dash_ready == true && timer.time_left == 0:
		dash_ready = false

func start_dash(dur):
	dashtimer.wait_time = dur
	dashtimer.start()
	
func is_dashing():
	return dashtimer.is_stopped() == false
