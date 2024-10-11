extends Camera2D

var player
var power_ups
var base_pos
var timer = 0
var rng = RandomNumberGenerator.new()
var rng_time
var rng_side
func _ready() -> void:
	player = $"../Player"
	power_ups = $"../power_ups"
	base_pos = 55
	rng_time = rng.randf_range(7, 20)
	#rng_side = rng.randi_range(0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	timer += delta
	if timer > rng_time:
		var bat = load("res://Enemy/bat.tscn").instantiate()
		bat.position.x = randf_range(-200, 600)
		bat.position.y = position.y - 240
		get_parent().add_child(bat)
		timer = 0
		rng_time = rng.randf_range(7, 20)
		rng_side = rng.randi_range(0, 1)
	position.y = move_toward(position.y, player.position.y - base_pos, (delta * pow(1.1, (abs(player.position.y - position.y - base_pos)))))
	power_ups.position = position
