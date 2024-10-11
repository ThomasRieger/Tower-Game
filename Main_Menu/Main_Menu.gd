extends Control

var timer = 0
var timer2 = 0
var done = false
@onready var title_top = $title_top
@onready var title_bottom = $title_bottom
@onready var base_pos = title_top.position.y

func _ready() -> void:
	AudioController.bgm_ambience()
	AudioController.bgm_intro()
	
func _physics_process(delta: float) -> void:
	timer += delta
	if timer > 0.1 and title_top.frame != 13:
		title_top.frame += 1
		timer = 0
	elif timer > 0.1:
		timer = 0
		title_top.frame = 0
	if title_top.position.y < base_pos:
		timer2 += delta
		if timer2 > 3:
			get_tree().change_scene_to_file("res://Main_Menu/After_Start/Main_entrance.tscn")

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouseButton) and !done:
		done = true
		var tween1 = create_tween()
		tween1.tween_property(title_top, "position:y", title_top.position.y - 1080, 3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
		var tween2 = create_tween()
		tween2.tween_property(title_bottom, "position:y", title_bottom.position.y - 1080, 3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Menu/After_Start/Main_entrance.tscn")
	#print("yes")
