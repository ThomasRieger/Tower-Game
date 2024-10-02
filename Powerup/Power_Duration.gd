extends Node
signal End_Duration

@onready var label = $Lable
@onready var timer = $Timer

var power_active = false
var time_left = 0.0
var time_start = 11

# Setting up
func _ready() -> void:
	label.visible = false
	timer.stop()

# Power up Preset
# Reset timer
#	timer.stop()
#	power_active = false
#	# Start timer
#	if !power_active:
#		power_active = true
#		timer.start(time_start)
#		label.visible = true

# Count Down
func _process(delta: float) -> void:
	if power_active:
		time_left = int(timer.time_left)
		label.text = "%02d" % time_left
		if time_left <= 0:
			power_active = false
			label.visible = false
			timer.stop()
			emit_signal("End_Duration")

func reset_power():
	power_active = false
	

# Dash Power
func _on_dash_power_dash_ready_signal() -> void:
# Reset timer
	timer.stop()
	power_active = false
	# Start timer
	if !power_active:
		power_active = true
		timer.start(time_start)
		label.visible = true

func _on_double_jump_dj_ready_signal() -> void:
	# Reset timer
	timer.stop()
	power_active = false
	# Start timer
	if !power_active:
		power_active = true
		timer.start(time_start)
		label.visible = true

func _on_speed_boost_speed_ready_signal() -> void:
	# Reset timer
	timer.stop()
	power_active = false
	# Start timer
	if !power_active:
		power_active = true
		timer.start(time_start)
		label.visible = true

func _on_dash_power_2_dash_ready_signal() -> void:
# Reset timer
	timer.stop()
	power_active = false
	# Start timer
	if !power_active:
		power_active = true
		timer.start(time_start)
		label.visible = true
