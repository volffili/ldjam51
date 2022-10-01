extends RigidBody2D

var hp = 30

func hit(dmg):
	hp -= dmg
	if hp <= 0:
		$CollisionShape2d.set_deferred("disabled", true)
		$AnimationPlayer.play("death")
