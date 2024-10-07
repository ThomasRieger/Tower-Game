extends Area2D

var entered = false
var num = 0

func _on_body_entered(_body: Node2D) -> void:
	num += 1
	if num > 1:
		await get_tree().create_timer(0.01).timeout
		SceneTransition.change_scene("res://main/Start_floor_1.tscn")
