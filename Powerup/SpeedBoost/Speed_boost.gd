extends Node2D

signal speed_ready_signal

var SP_ready = false
@onready var timer = $Timer
@onready var sptimer = $djtimer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && visible:
		SP_ready = true
		visible = false
		emit_signal("speed_ready_signal")
		timer.start(10)

func _physics_process(delta: float) -> void:
	if SP_ready == true && timer.time_left <= 0.1:
		SP_ready = false

func start_sp(dur):
	sptimer.wait_time = dur
	sptimer.start()
	
func is_sping():
	return not sptimer.is_stopped()
