extends "res://upgrades/upgrade.gd"

var shot_scene = preload("res://shot.tscn")

func _on_shoot(shot):
	if shot.duplicated_triple:
		return
	for i in [-25, +25]:
		var new_shot = shot_scene.instantiate()
		new_shot.position = shot.position
		new_shot.duplicated_triple = true
		new_shot.duplicated_chain = shot.duplicated_chain
		player.emit_signal("shot_created", new_shot)
		player.get_parent().call_deferred("add_child", new_shot)
		new_shot.call_deferred("shoot", (get_global_mouse_position() - player.global_position).rotated(deg_to_rad(i + randi_range(-5, 5))))
