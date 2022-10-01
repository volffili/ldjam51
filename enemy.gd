extends RigidBody2D

var hp = 30

func _ready():
	var t = Timer.new()
	await get_tree().create_timer(randf()).timeout
	$Icon.playing = true
	$AnimationPlayer.play("move")

func hit(dmg):
	hp -= dmg
	if hp <= 0:
		$CollisionShape2d.set_deferred("disabled", true)
		$AnimationPlayer.play("death")

func move():
	var direction = (get_node("/root/Game/player").global_position - self.global_position).normalized()
	apply_force(Vector2(direction.x,direction.y * (abs(cos(direction.angle()))/2+0.75))*4000)
	$AnimationPlayer.play("move")
