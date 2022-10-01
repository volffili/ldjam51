extends RigidBody2D

var point_light_scene = preload("res://point_light.tscn")
var boom_scene = preload("res://boom.tscn")

signal impact

var damage = 10
var speed = 500
var my_point_light

func shoot(direction):
	linear_velocity = direction.normalized() * speed * (abs(cos(direction.angle()))/2+0.75)
	$GpuParticles2d.rotation = direction.angle()
	
	my_point_light = point_light_scene.instantiate()
	get_parent().add_child(my_point_light)
	my_point_light.assign(self)


func _on_shot_body_entered(body):
	body.hit(damage)
	$CollisionShape2d.set_deferred("disabled", true)
	$AnimationPlayer.play("hit")
	var boom = boom_scene.instantiate()
	boom.position = position
	get_parent().add_child(boom)
	$GpuParticles2d.emitting = false
	my_point_light.clear_assigned()
	my_point_light.die()
	my_point_light = null
	emit_signal("impact", self, body)

func _on_collision_shape_2d_tree_exited():
	if my_point_light:
		my_point_light.queue_free()
		my_point_light.die()
