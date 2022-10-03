extends "res://upgrades/upgrade.gd"

var effect_scene = preload("res://upgrades/charge_up_effect.tscn")
var effect

func _on_picked():
	player.charge_up = true
	effect = effect_scene.instantiate()
	player.add_child(effect)

func _process(delta):
	if effect == null:
		return
	effect.get_node("Particles").emitting = Input.is_action_pressed("shoot")
		
