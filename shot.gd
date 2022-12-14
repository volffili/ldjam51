extends RigidBody2D

var point_light_scene = preload("res://point_light.tscn")
var boom_scene = preload("res://boom.tscn")

signal impact
signal shot_process

var damage = 10
var speed = 500
var my_point_light
var boom
var duplicated_triple = false
var duplicated_chain = false
var ignore_enemy = null
var piercing = false

func shoot(direction):
	linear_velocity = direction.normalized() * speed * (abs(cos(direction.angle()))/2+0.75) * (0.8 + randf() * 0.4)
	$GpuParticles2d.rotation = direction.angle()
	#$GpuParticles2d.process_material.scale_min = damage / 4
	$GpuParticles2d.process_material.scale_max = max(3, damage / 2.0)
	$GpuParticles2d.scale *= max(damage / 10.0, 0.8)
	var shape = CircleShape2D.new()
	shape.radius = sqrt(damage) / 3.1 * 10.0
	$CollisionShape2d.set_shape(shape)
	
	if len(get_tree().get_nodes_in_group("light")) < 16:
		my_point_light = point_light_scene.instantiate()
		get_parent().add_child(my_point_light)
		my_point_light.assign(self)

func _on_shot_body_entered(body):
	if body == ignore_enemy:
		return
	
	body.hit(damage)
	
	if not piercing:
		$CollisionShape2d.set_deferred("disabled", true)
		$AnimationPlayer.play("hit")
		$GpuParticles2d.emitting = false
		if is_instance_valid(my_point_light):
			my_point_light.clear_assigned()
			my_point_light.die()
	boom = boom_scene.instantiate()
	boom.position = position
	boom.modulate = modulate
	get_parent().add_child(boom)
	emit_signal("impact", self, body)
	get_node("/root/Game/player").shake_amount += damage / 3.0

func _on_collision_shape_2d_tree_exited():
	if is_instance_valid(my_point_light):
		my_point_light.queue_free()

func _process(delta):
	emit_signal("shot_process", delta)
