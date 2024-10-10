extends AudioStreamPlayer

const level_music = preload("res://assets/sound/bgm_doodle1.mp3")
func _play_music(music : AudioStream, volume = -8.0):
	if stream == music : return
	stream = music
	volume_db = volume
	play()
		
func play_music_level():
	_play_music(level_music)
	
