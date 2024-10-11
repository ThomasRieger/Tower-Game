extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		global.dash = false
		global.boss_health = 10
		global.is_dash = false
		global.double_jump = false
		global.speed_boost = 1
		global.wall_jump = false
		global.power_dur = 10
		global.power_time = [0, 0, 0, 0]
		await get_tree().create_timer(0.001).timeout
		get_tree().current_scene.get_node("Player").visible = false
		SceneTransition.change_scene("res://main/Start_floor_1.tscn")
		global.death += 1
