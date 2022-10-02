extends "res://upgrades/upgrade.gd"

var shot_scene = preload("res://shot.tscn")

func _on_impact(shot, enemy):
	if shot.duplicated_chain:
		return

	var nearest_enemy = null
	var dist = 100000000
	for e in get_tree().get_nodes_in_group("enemy"):
		if e == enemy:
			continue
		if nearest_enemy == null or e.global_position.distance_squared_to(shot.global_position) < dist:
			nearest_enemy = e
			dist = e.global_position.distance_squared_to(shot.global_position)

	if nearest_enemy == null:
		return
	
	var new_shot = shot_scene.instantiate()
	new_shot.global_position = shot.global_position
	new_shot.duplicated_chain = true
	new_shot.duplicated_triple = shot.duplicated_triple
	new_shot.damage /= 2
	new_shot.ignore_enemy = enemy
	new_shot.modulate *= Color.YELLOW
	player.emit_signal("shot_created", new_shot)
	player.get_parent().call_deferred("add_child", new_shot)
	new_shot.call_deferred("shoot", nearest_enemy.global_position - player.global_position)
