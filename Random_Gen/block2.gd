extends Node2D

@export var rand_speed_wheel1 = 0.7
@export var rand_speed_wheel2 = 0.7
var speed_wheel
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	speed_wheel = rng.randf_range(rand_speed_wheel1, rand_speed_wheel2)

func _physics_process(delta: float) -> void:
	rotate(speed_wheel * delta)
