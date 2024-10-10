extends Node2D

@onready var colli = $Area2D/CollisionShape2D
var rng = RandomNumberGenerator.new()
var timer = 0
var time_up = 0
var flying = false
@onready var base_pos = position

func _physics_process(delta: float) -> void:
	timer += delta
	if !global.double_jump:
		visible = true
		colli.disabled = false
	else:
		visible = false
		colli.disabled = true
		return
		
	if !flying:
		timer = 0
		var pos = Vector2(rng.randf_range(-4, 4), rng.randf_range(-4, 4)) + base_pos
		var degree = rng.randf_range(-0.3 , 0.3)
		time_up = rng.randf_range(0.7, 1.5)
		var tween1 = create_tween()
		tween1.tween_property(self, "position", pos, time_up).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		var tween2 = create_tween()
		tween2.tween_property(self, "rotation", degree, time_up).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		flying = true
	elif timer > time_up + 0.1:
		flying = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && visible:
		play_sfx(sfx_powerUp)
		global.double_jump = true
		global.power_time[1] = global.power_dur
		await get_tree().create_timer(0.01).timeout
		visible = false
		colli.disabled = true

#--------------------------Sounds--------------------------#
@export var sfx_powerUp : AudioStream
func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load
		
func play_sfx(sfx_to_play):
	load_sfx(sfx_to_play)
	%sfx_player.play()
