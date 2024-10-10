extends Control

@onready var main = $"../.."

func _on_resume_pressed() -> void:
	main.pause_menu()
	
func _on_restart_pressed() -> void:
	main.pause_menu()
	BgmPlayer.play()
	SceneTransition.change_scene("res://main/Start_floor_1.tscn")

func _on_quit_pressed() -> void:
	main.pause_menu()
	SceneTransition.change_scene("res://Main_Menu/Main_Menu.tscn")
	BgmPlayer.stop()
