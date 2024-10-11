extends Node2D

@onready var dash_label = $"power_ups/dash_icon/Label"
@onready var dash_icon = $"power_ups/dash_icon"
@onready var djump_label = $"power_ups/djump_icon/Label"
@onready var djump_icon = $"power_ups/djump_icon"
@onready var speed_label = $"power_ups/speed_icon/Label"
@onready var speed_icon = $"power_ups/speed_icon"
@onready var wall_label = $"power_ups/wall_icon/Label"
@onready var wall_icon = $"power_ups/wall_icon"
@onready var pausemenu = $Camera2D/Pause_menu

var paused = false

func _ready() -> void:
	$Attempts.text = "Attempt %d" % global.death
	#BgmPlayer.play_music_level()	
	#BgmPlayer.play()
	AudioController.play_bgm()

func _physics_process(delta: float) -> void:
	if global.dash:
		global.power_time[0] -= delta
		if global.power_time[0] <= 0:
			global.power_time[0] = 0
			global.dash = false
			dash_icon.visible = false
			return
		dash_label.text = "%0.1f" % global.power_time[0]
		dash_icon.visible = true
	if global.double_jump:
		global.power_time[1] -= delta
		if global.power_time[1] <= 0:
			global.power_time[1] = 0
			global.double_jump = false
			djump_icon.visible = false
			return
		djump_label.text = "%0.1f" % global.power_time[1]
		djump_icon.visible = true
	if global.speed_boost != 1:
		global.power_time[2] -= delta
		if global.power_time[2] <= 0:
			global.power_time[2] = 0
			global.speed_boost = 1
			speed_icon.visible = false
			return
		speed_label.text = "%0.1f" % global.power_time[2]
		speed_icon.visible = true
	if global.wall_jump:
		global.power_time[3] -= delta
		if global.power_time[3] <= 0:
			global.power_time[3] = 0
			global.wall_jump = false
			wall_icon.visible = false
			return
		wall_label.text = "%0.1f" % global.power_time[3]
		wall_icon.visible = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pause_menu()
	if global.boss_health <= 0:
		SceneTransition.change_scene("res://Ending.tscn")
		$Camera2D/Stopwatch.stop()
		
func pause_menu():
	if paused:
		pausemenu.hide()
		AudioController.resume_bgm()
		Engine.time_scale = 1
	else:
		pausemenu.show()
		AudioController.pause_bgm()
		Engine.time_scale = 0
	
	paused = !paused
