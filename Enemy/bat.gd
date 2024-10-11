extends Node2D


var player

func _physics_process(delta: float) -> void:
	player = get_tree().current_scene.get_node("Player")
	if get_tree().current_scene.get_node("Player") != null:
		position.x = move_toward(position.x, player.position.x, 0.5 + delta * abs(position.x - player.position.x) * 0.5)
		position.y = move_toward(position.y, player.position.y - 8, 0.5 + delta * abs(position.y - player.position.y) * 0.5)
		#move_and_slide()
		if position.x > player.position.x:
			scale.x = -1
		else:
			scale.x = 1
	if global.boss_health <= 0:
		self.queue_free()

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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "bulley":
		queue_free()
	#print(area)
