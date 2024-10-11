extends Area2D

@export var speed = 500
var collision = false

func _ready() -> void:
	top_level = true

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
@warning_ignore("unused_parameter")
func _physics_process(delta):
	set_physics_process(true)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if !collision:
		if !body.name == "Player":
			if body.name.begins_with("Enemy"):
				body.take_damage(1)
			AudioController.sfx_bulletHit()
			$Splash.emitting = true
			$bulley/CollisionShape2D.position = Vector2(1000,1000)
			speed = 0
			collision = true
			$Sprite2D.visible = false
			await get_tree().create_timer(0.3).timeout
			
	else:
		collision = false
