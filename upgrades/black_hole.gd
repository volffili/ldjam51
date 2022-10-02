extends "res://upgrades/upgrade.gd"

var black_hole_scene = preload("res://upgrades/black_hole_effect.tscn")

var impact = false

func _on_shoot(shot):
	var b = black_hole_scene.instantiate()
	shot.add_child(b)
	shot.connect("impact", func(shot, enemy): 
		if impact:
			return
		impact = true
		var g = b.global_position
		shot.remove_child(b)
		shot.get_parent().add_child(b)
		b.global_position = g
		await get_tree().create_timer(2.0).timeout
		b.queue_free()
	)
