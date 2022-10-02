extends "res://upgrades/upgrade.gd"

func _on_shoot(shot):
	shot.speed /= 10
	shot.connect("shot_process", func(delta): 
		shot.apply_central_impulse((get_global_mouse_position() - shot.global_position).normalized() * shot.mass * 15)
	)
