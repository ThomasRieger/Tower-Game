extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		global.dash = false
		global.is_dash = false
		global.double_jump = false
		global.speed_boost = 1
		global.wall_jump = false
		global.power_dur = 10
		global.power_time = [0, 0, 0, 0]
		get_tree().current_scene.get_node("Player").visible = false
		await get_tree().create_timer(0.01).timeout
		SceneTransition.change_scene("res://main/Start_floor_1.tscn")
		global.death += 1
