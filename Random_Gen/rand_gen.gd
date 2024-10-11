extends Node

var stopper = 0
var rng = RandomNumberGenerator.new()
var i = 1
var power = false
var flip = false

#func p_pos_finder(p_poss, pos_x):
	#match p_poss:
		#1:
			#

func spawn(scene, ii, pos_x):
	var ob = load(scene).instantiate()
	ob.position = Vector2(pos_x, -(ii + 1) * 32)
	if flip:
		flip = false
		ob.scale.x = -1
	add_child(ob)
	if power:
		power = false
		match rng.randi_range(1, 4):
			1:
				var p = load("res://Powerup/Dash/Dash_Power.tscn").instantiate()
				p.position = ob.position - Vector2(0, 20)
				add_child(p)
			2:
				var p = load("res://Powerup/DoubleJump/DoubleJump.tscn").instantiate()
				p.position = ob.position - Vector2(0, 20)
				add_child(p)
			3:
				var p = load("res://Powerup/SpeedBoost/SpeedBoost.tscn").instantiate()
				p.position = ob.position - Vector2(0, 20)
				add_child(p)
			4:
				var p = load("res://Powerup/WallJump/WallJump.tscn").instantiate()
				p.position = ob.position - Vector2(0, 20)
				add_child(p)
func random_room():
	match rng.randi_range(1, 17):
					1:
						if rng.randi_range(0, 1):
							flip = true
						spawn("res://Random_Gen/room1.tscn", i, 240)
						i += 7.5
					2:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room2.tscn", i, 240)
						i += 12
					3:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room3.tscn", i, 240)
						i += 5.8
					4:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room4.tscn", i, 240)
						i += 8.4
					5:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room5.tscn", i, 240)
						i += 4.5
					6:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room6.tscn", i, 240)
						i += 4
					7:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room7.tscn", i, 240)
						i += 6.5
					8:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room8.tscn", i, 240)
						i += 7
					9:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room9.tscn", i, 240)
						i += 12.2
					10:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room10.tscn", i, 240)
						i += 7.3
					11:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room11.tscn", i, 240)
						i += 12.1
					12:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room12.tscn", i, 240)
						i += 9.5
					13:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room13.tscn", i, 240)
						i += 16
					14:
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room14.tscn", i, 240)
						i += 6.9
					15:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1.2)
						spawn("res://Random_Gen/room15.tscn", i, 240)
						i += 7.5
					16:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1)
						spawn("res://Random_Gen/room16.tscn", i, 240)
						i += 8.9
					17:
						if rng.randi_range(0, 1):
							flip = true
						i += rng.randf_range(0.6, 1)
						spawn("res://Random_Gen/room17.tscn", i, 240)
						i += 10.5

func _ready() -> void:
	while(i < 100):
		match rng.randi_range(0, 3):
			0:
				#platform flooring for 1 to 10
				for j in range(rng.randi_range(1, 10)):
					var rand = rng.randi_range(3, 7)
					match rand:
						1:
							spawn("res://Random_Gen/brick1.tscn", i, randi_range(120, 360))
						2:
							spawn("res://Random_Gen/brick2.tscn", i, randi_range(100, 360))
						3:
							power = true
							spawn("res://Random_Gen/brick3.tscn", i, randi_range(110, 340))
						4:
							stopper += 1
							if stopper > 0:
								spawn("res://Random_Gen/brick2.tscn", i, randi_range(66, 414))
								stopper = 0
							else:
								spawn("res://Random_Gen/brick2.tscn", i, randi_range(100, 360))
						5:
							stopper += 1
							if stopper > 0:
								spawn("res://Random_Gen/brick1.tscn", i, randi_range(120, 360))
								stopper = 0
						6:
							spawn("res://Random_Gen/brick2.tscn", i, randi_range(66, 150))
							spawn("res://Random_Gen/brick2.tscn", i, randi_range(250, 414))
						7:
							spawn("res://Random_Gen/brick1.tscn", i, randi_range(57, 190))
							spawn("res://Random_Gen/brick1.tscn", i, randi_range(210, 423))
					i += rng.randf_range(0.6, 1.2)
				stopper = 0
			1:
				random_room()
			2:
				random_room()
			3:
				random_room()
				
	i += rng.randf_range(0.6, 1)
	spawn("res://Random_Gen/boss_room.tscn", i, 240)
		#match rng.randi_range()
		#rng.randi_range(0, 1000)
