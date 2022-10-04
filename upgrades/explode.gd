extends "res://upgrades/upgrade.gd"

var effect_scene = preload("res://upgrades/explode_effect.tscn")

func _on_impact(shot, enemy):
	var pos = enemy.global_position
	var damage = shot.damage
	if shot.my_point_light:
		shot.my_point_light.color = Color.DARK_ORANGE
	await get_tree().process_frame
	var effect = effect_scene.instantiate()
	get_node("/root/Game").add_child(effect)
	effect.global_position = pos
	effect.get_node("Explode").connect("body_entered", func(enemy):
		enemy.hit(7.0)
	)
