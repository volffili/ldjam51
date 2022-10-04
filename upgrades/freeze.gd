extends "res://upgrades/upgrade.gd"

func _on_shoot(shot):
	shot.modulate *= Color.LIGHT_BLUE

func _on_impact(shot, enemy):
	var orig_m = enemy.modulate
	var orig_s = enemy.speed
	enemy.modulate = Color.LIGHT_BLUE
	enemy.speed = 0
	enemy.linear_velocity = Vector2.ZERO
	enemy.get_node("Icon").playing = false
	await get_tree().create_timer(4.0).connect("timeout", func():
		if is_instance_valid(enemy):
			enemy.modulate = orig_m
			enemy.speed = orig_s
			enemy.get_node("Icon").playing = true
	)
