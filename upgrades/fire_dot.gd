extends "res://upgrades/upgrade.gd"

var effect_scene = preload("res://upgrades/fire_dot_effect.tscn")

func _on_shoot(shot):
	shot.modulate *= Color.DARK_ORANGE # TODO

func _on_impact(shot, enemy):
	var effect = effect_scene.instantiate()
	enemy.add_child(effect)
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 0.2
	timer.connect("timeout", func(): enemy.hit(1))
	enemy.add_child(timer)
	timer.start()
	await get_tree().create_timer(5.0).connect("timeout", func():
		if is_instance_valid(timer):
			timer.queue_free()
		if is_instance_valid(effect):
			effect.queue_free()
	)
