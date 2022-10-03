extends RigidBody2D

var enemy_scene = load("res://enemy.tscn")

@export var hp = 30
@export var speed = 7000
var died = false
var should_split = false

func _ready():
	get_tree().create_timer(randf()*3).connect("timeout", start)

func start():
	if died:
		return
	$Icon.playing = true
	$AnimationPlayer.play("move")

func hit(dmg):
	hp -= dmg
	$HitAudio.play()
	if hp <= 0 and not died:
		died = true
		$DeathAudio.play()		
		$CollisionShape2d.set_deferred("disabled", true)
		$AnimationPlayer.play("death")
		
		if should_split:
			var e1 = enemy_scene.instantiate()
			e1.position = position + Vector2(-10, 0)
			e1.get_node("Icon").scale /= 1.5
			e1.hp /= 2.0
			get_parent().call_deferred("add_child", e1)
			
			var e2 = enemy_scene.instantiate()
			e2.position = position + Vector2(10, 0)
			e2.get_node("Icon").scale /= 1.5
			e2.hp /= 2.0
			get_parent().call_deferred("add_child", e2)

func move():
	var direction = (get_node("/root/Game/player").global_position - self.global_position).normalized()
	apply_force(Vector2(direction.x,direction.y * (abs(cos(direction.angle()))/2.0+0.75))*speed)
	if not died:
		$WalkAudio.play()
		$AnimationPlayer.play("move")


func _on_enemy_body_entered(body):
	if not body.is_in_group("player"):
		return
	get_node("/root/Game/player/DeathLabel").visible = true
