extends Node2D

var once = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.boss_health <= 0 and !once:
		$AnimatedSprite2D.play("Ending")
		once = true
	#if $AnimatedSprite2D.animation_finished and once:
				
			
func _on_restart_pressed() -> void:
	SceneTransition.change_scene("res://Main_Menu/Main_Menu.tscn")
	AudioController.stop_bgm()
	global.boss_health = 10

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("EndMenu")
	$AnimatedSprite2D.position.y -= 25
	$AnimatedSprite2D.position.x -= 10
	$Restart.visible = true
	$Label_attempt.visible = true
	$Label_timer.visible = true
	$Label_attempt.text = "Attempts: %d" % global.death	
	$Label_timer.text = "Timer: %0.2f" % global.timer
