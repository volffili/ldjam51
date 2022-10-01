extends RigidBody2D

var damage = 10
var speed = 500

func shoot(direction):
	linear_velocity = direction.normalized() * speed
	$GpuParticles2d.rotation = direction.angle()

func _on_shot_body_entered(body):
	body.hit(damage)
	$CollisionShape2d.set_deferred("disabled", true)
	$AnimationPlayer.play("hit")
