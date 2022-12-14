extends CharacterBody2D

signal shot_created

var shot_scene = preload("res://shot.tscn")
var speed = 80.0
var reload_time = 0.8
var reload_time_left = 0.0
var charge_up = false
var charge_time = 0.0
var recoil = Vector2.ZERO
var shake_amount = 0.0
var dead = false

func _physics_process(delta):
	if dead:
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("up", "down")
	if horizontal:
		$Sprite2d.set_scale(Vector2(horizontal,1))
	$AudioStreamPlayer.stream_paused = not (horizontal or vertical)
	var dir = Vector2(horizontal, vertical).normalized()
	velocity = lerp(velocity, dir * speed * (abs(cos(dir.angle()))/2.0+0.75), 0.15)
	velocity += recoil
	recoil *= 0.9

	move_and_slide()
	
func _process(delta):
	if dead:
		return

	reload_time_left -= delta
	if Input.is_action_pressed("shoot") and reload_time_left <= 0:
		if charge_up:
			charge_time += delta
		else:
			shoot()
			reload_time_left = reload_time
	elif charge_up and charge_time > 0:
		shoot(min(1 + (charge_time / reload_time) * 2, 10))
		charge_time = 0
		reload_time_left = reload_time
		
	shake_amount = min(shake_amount, 8.0)
	get_node("Camera2d").set_offset(Vector2(
		randf_range(-1.0, 1.0) * shake_amount,
		randf_range(-1.0, 1.0) * shake_amount
	))
	shake_amount *= 0.8
	
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()

func shoot(dmg = 1):
	var shot = shot_scene.instantiate()
	shot.position = Vector2(position.x,position.y-20)
	shot.damage *= dmg
	shot.get_node("AudioStreamPlayer").autoplay = true
	shot.get_node("AudioStreamPlayerSmall").autoplay = false
	emit_signal("shot_created", shot)
	get_parent().add_child(shot)
	shot.shoot(get_global_mouse_position() - global_position)
	recoil += (global_position - get_global_mouse_position()).normalized() * log(shot.damage) * 10
	shake_amount += shot.damage / 5.0
	
func death():
	if dead:
		return
	dead = true
	$DeathAudio.play()
	get_node("/root/Game/HUD").show_text("", "")
	get_node("/root/Game/HUD/death").visible = true
