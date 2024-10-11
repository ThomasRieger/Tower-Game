extends Node2D

@export var mute : bool = false

func _ready() -> void:
	if not mute:
		pass

func play_bgm():
	if not mute:
		$Music.play()

func stop_bgm():
	if not mute:
		$Music.stop()

func pause_bgm():
	$Music.stream_paused = true

func resume_bgm():
	$Music.stream_paused = false

func sfx_powerUp():
	$PowerUp.play()

func sfx_fire():
	$GunShoot.play()
	
func sfx_bulletHit():
	$BulletHit.play()

func bgm_ambience():
	$Ambience.play()
	
func stop_ambience():
	$Ambience.stop()
	
func bgm_intro():
	$Intro_bgm.play()
	
func stop_intro():
	$Intro_bgm.stop()

func sfx_titleDrop():
	$titleDrop.play()
