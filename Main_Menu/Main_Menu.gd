extends Control

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Menu/After_Start/Main_entrance.tscn")
	print("yes")
