extends Node

@onready var pickup = $"../Dash_pickup"
@onready var lable = $Label
@onready var timer = $Timer


func _process(delta: float) -> void:
	lable.visible = false
	if pickup.dash_ready:
		lable.visible = true
		timer.start()
		var time_left = timer.time_left
		var second = int(time_left)
		if second <= 0:
			lable.text = "%02d" % second
