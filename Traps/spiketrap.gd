extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Spike")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://main/Start_floor_1.tscn")
