extends Node

var dash = false
var boss_health = 10
var is_dash = false
var double_jump = false
var speed_boost = 1
var wall_jump = false
var power_dur = 10
#power_time 0 -> dash ||| 1 -> double_jump ||| 2 -> speed_boost || 3 -> wall jump
var power_time = [0, 0, 0, 0]
var death := 0
var timer = 0.00
