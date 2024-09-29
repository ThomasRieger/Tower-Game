extends Area2D

var entered = false

func Player_entered(body: PhysicsBody2D) -> void:
	entered = true

func _physics_process(delta):
	if entered == true:
		get_tree().change_scene_to_file("res://main/Start_floor_1.tscn")
		print("Entered")
