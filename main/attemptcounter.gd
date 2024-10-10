extends Node2D

var attempts = 0

@onready var AttemptLable = $Attempt

func Attempt_increase():
	attempts += 1
	AttemptLable.text = "Attempts %d" % attempts
	
func reset_attempts():
	attempts = 0
	AttemptLable.text = "Attempts 0"
