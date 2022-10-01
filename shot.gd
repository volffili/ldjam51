extends RigidBody2D

var damage = 10

func _on_shot_body_entered(body):
	body.hit(damage)
	$CollisionShape2d.set_deferred("disabled", true)
	$AnimationPlayer.play("hit")
