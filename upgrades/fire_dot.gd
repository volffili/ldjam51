extends "res://upgrades/upgrade.gd"

var effect_scene = preload("res://upgrades/fire_dot_effect.tscn")

func _on_shoot(shot):
	shot.modulate *= Color.DARK_ORANGE # TODO

func _on_impact(shot, enemy):
	enemy.add_child(effect_scene.instantiate())
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 0.2
	timer.connect("timeout", func(): enemy.hit(1))
	enemy.add_child(timer)
	timer.start()
