extends Node2D

var once = false
@export var sfx_explode : AudioStream
var explode_crystal : Array = [22]
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
	$AnimatedSprite2D.position.x -= 25
	$Restart.visible = true
	$Label_attempt.visible = true
	$Label_timer.visible = true
	AudioController.sfx_titleDrop()
	$Label_attempt.text = "Attempts: %d" % global.death	
	$Label_timer.text = "Timer: %0.2f" % global.timer

#--------------------------Sounds--------------------------#
func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load
		
func play_sfx(sfx_to_play):
	load_sfx(sfx_to_play)
	%sfx_player.play()

func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "EndMenu": return
	load_sfx(sfx_explode)
	if $AnimatedSprite2D.frame in explode_crystal:
		%sfx_player.play()
		
