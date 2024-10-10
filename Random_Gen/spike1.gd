extends Node2D

var timer = 0
var up = false
var down = true
var base_pos_y
var base_pos_x
var amount_y
var amount_x

func _ready() -> void:
	base_pos_y = position.y
	base_pos_x = position.x
	amount_y = 6 * scale.y
	amount_x = 6 * scale.y
	pass
func _physics_process(delta: float) -> void:
	timer += delta
	if timer > 1.2 and !up:
		timer = -0.2
		up = true
		down = false
		if int(rotation_degrees) == 0:
			var tween1 = create_tween()
			tween1.tween_property(self, "position:y", base_pos_y - amount_y, 0.6).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		else:
			var tween1 = create_tween()
			tween1.tween_property(self, "position:x", base_pos_x + amount_x, 0.6).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	elif timer > 0.6 and !down:
		timer = -0.8
		down = true
		up = false
		if int(rotation_degrees) == 0:
			var tween2 = create_tween()
			tween2.tween_property(self, "position:y", base_pos_y, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		else:
			var tween2 = create_tween()
			tween2.tween_property(self, "position:x", base_pos_x, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

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
