extends Node2D

var timer = 0
var up = false
@onready var progress_health = $Node2D/TextureProgressBar
@onready var label = $labelnode/Label
@onready var base_pos = position
@onready var base_pos_label = $labelnode.position
@onready var labelnode = $labelnode
var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	timer += delta
	if timer > 1.1 and !up:
		up = true
		if global.boss_health <= 10:
			global.boss_health += 0.2
		timer = 0
		var tween1 = create_tween()
		tween1.tween_property(self, "position:y", base_pos.y - 20, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	elif timer > 1.1 and up:
		up = false
		if global.boss_health <= 10:
			global.boss_health += 0.2
		timer = 0
		var tween1 = create_tween()
		tween1.tween_property(self, "position:y", base_pos.y, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_boss_area_entered(area: Area2D) -> void:
	if area.name == "player" or area.name == "bulley":
		label.visible = false
		#print(health)
		global.boss_health -= 1
		progress_health.value = global.boss_health
		if global.boss_health <= 0:
			self.queue_free()
		await get_tree().create_timer(0.001).timeout
	#if randi_range(1, 2) == 1:
		var bat = load("res://Enemy/bat.tscn").instantiate()
		bat.position.x = randf_range(-200, 600)
		bat.position.y = position.y - 170 + get_tree().current_scene.get_node("Player").position.y
		get_tree().current_scene.add_child(bat)
