extends "res://upgrades/upgrade.gd"

func _on_shoot(shot):
	shot.piercing = true
	shot.modulate *= Color.LIGHT_GREEN
