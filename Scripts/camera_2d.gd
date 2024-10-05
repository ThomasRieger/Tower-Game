extends Camera2D

var player
var power_ups
var base_pos
var timer = 0
func _ready() -> void:
	player = $"../Player"
	power_ups = $"../power_ups"
	base_pos = 55

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y = move_toward(position.y, player.position.y - base_pos, (delta * pow(1.1, (abs(player.position.y - position.y - base_pos)))))
	power_ups.position = position
