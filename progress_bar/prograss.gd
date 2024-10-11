extends Node2D

@onready var progress_bar = $TextureProgressBar
@onready var player = $"../Player"
@onready var label = $Label
@onready var camera = $"../Camera2D"
var pro_num = 0

func _physics_process(delta: float) -> void:
	pro_num = abs((52.5 + player.position.y) / (54 - (100 * 32))) * 100
	if pro_num >= 100:
		pro_num = 100.00
	progress_bar.value = pro_num
	label.text = "%0.2f" % pro_num + "%"
	position.y = -110 + camera.position.y
