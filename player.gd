extends CharacterBody2D

signal shot_created

var shot_scene = preload("res://shot.tscn")
var speed = 80.0
var reload_time = 0.8
var reload_time_left = 0.0
var charge_up = false
var charge_time = 0.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("up", "down")
	if horizontal:
		$Sprite2d.set_scale(Vector2(horizontal,1))
	if horizontal or vertical:
		var dir = Vector2(horizontal, vertical).normalized()
		velocity = dir * speed * (abs(cos(dir.angle()))/2.0+0.75)
	else:
		velocity.x = move_toward(velocity.x, 0, speed/15.0)
		velocity.y = move_toward(velocity.y, 0, speed/15.0)

	move_and_slide()
	
func _process(delta):
	reload_time_left -= delta
	if Input.is_action_pressed("shoot") and reload_time_left <= 0:
		if charge_up:
			charge_time += delta
		else:
			shoot()
			reload_time_left = reload_time
	elif charge_up and charge_time > 0:
		shoot(min(1 + (charge_time / reload_time), 5))
		charge_time = 0

func shoot(dmg = 1):
	var shot = shot_scene.instantiate()
	shot.position = Vector2(position.x,position.y-20)
	shot.damage *= dmg
	emit_signal("shot_created", shot)
	get_parent().add_child(shot)
	shot.shoot(get_global_mouse_position() - global_position)
