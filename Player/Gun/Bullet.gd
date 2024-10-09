extends Area2D

@export var speed = 200
var hit = 0

func _ready() -> void:
	top_level = true

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	Vector2(1,0)
	
@warning_ignore("unused_parameter")
func _physics_process(delta):
	set_physics_process(true)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if !body.name == "Player":
		if body.name == "Enemy":
			body.take_damage(1)
		queue_free()
