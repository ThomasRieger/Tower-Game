extends Control

@onready var main = $"../.."

func _on_resume_pressed() -> void:
	main.pause_menu()
	
func _on_restart_pressed() -> void:
	main.pause_menu()
	AudioController.play_bgm()
	SceneTransition.change_scene("res://main/Start_floor_1.tscn")
	global.dash = false
	global.is_dash = false
	global.double_jump = false
	global.speed_boost = 1
	global.wall_jump = false
	global.power_dur = 10
	global.power_time = [0, 0, 0, 0]
	
func _on_quit_pressed() -> void:
	main.pause_menu()
	SceneTransition.change_scene("res://Main_Menu/Main_Menu.tscn")
	AudioController.stop_bgm()
