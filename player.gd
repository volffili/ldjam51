extends CharacterBody2D

signal shot_created

var shot_scene = preload("res://shot.tscn")
const SPEED = 300.0
var reload_time = 0.3
var reload_time_left = 0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("up", "down")
	if horizontal or vertical:
		velocity = Vector2(horizontal, vertical).normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _process(delta):
	reload_time_left -= delta
	if Input.is_action_pressed("shoot") and reload_time_left <= 0:
		shoot()
		reload_time_left = reload_time
		
func shoot():
	var shot = shot_scene.instantiate()
	shot.position = Vector2(position.x,position.y-20)
	emit_signal("shot_created", shot)
	get_parent().add_child(shot)
	shot.shoot(get_global_mouse_position() - global_position)
