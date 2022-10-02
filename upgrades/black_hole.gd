extends "res://upgrades/upgrade.gd"

var black_hole_scene = preload("res://upgrades/black_hole_effect.tscn")

func _on_shoot(shot):
	var b = black_hole_scene.instantiate()
	shot.add_child(b)
	var impact = false
	shot.connect("impact", func(shot, enemy): 
		if impact:
			return
		impact = true
		var g = b.global_position
		shot.remove_child(b)
		shot.get_parent().call_deferred("add_child", add_child(b))
		b.set_deferred("global_position", g)
		await get_tree().create_timer(2.0).timeout
		b.queue_free()
	)
