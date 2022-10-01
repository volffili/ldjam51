extends Area2D

var player
@export var other_upgrade : Node2D

func _on_body_entered(p):
	player = p
	player.connect("shot_created", self._on_shoot_base)
	$CollisionShape2d.set_deferred("disabled", true)
	hide()
	other_upgrade.queue_free()
	_on_picked()

func _on_shoot_base(shot):
	shot.damage *= 2.0
	shot.connect("impact", self._on_impact)
	_on_shoot(shot)
	
func _on_picked():
	pass
	
func _on_shoot(shot):
	pass

func _on_impact(shot, enemy):
	pass
