extends Node2D
signal DJ_ready_signal

var DJ_ready = false
@onready var timer = $Timer
@onready var djtimer = $djtimer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && visible:
		DJ_ready = true
		visible = false
		emit_signal("DJ_ready_signal")
		timer.start(10)

func _physics_process(delta: float) -> void:
	if DJ_ready == true && timer.time_left <= 0.1:
		DJ_ready = false

func start_dj(dur):
	djtimer.wait_time = dur
	djtimer.start()
	
func is_djing():
	return not djtimer.is_stopped()
