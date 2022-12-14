extends Area2D

var player
@export var other_upgrade : Node2D
@export var title : String = ""
@export var subtext : String = ""
var start_y
var shadow_start_y
var time = 0

func _ready():
	start_y = position.y
	shadow_start_y = $Shadow.global_position.y - 3

func _on_body_entered(p):
	get_node("/root/Game/HUD").show_text(title, subtext)
	player = p
	player.connect("shot_created", self._on_shoot_base)
	player.get_node("UpgradeAudio").play()
	$CollisionShape2d.set_deferred("disabled", true)
	hide()
	if other_upgrade:
		other_upgrade.queue_free()
	_on_picked()

func _on_shoot_base(shot):
	shot.connect("impact", self._on_impact)
	_on_shoot(shot)

func _on_picked():
	pass
	
func _on_shoot(shot):
	pass

func _on_impact(shot, enemy):
	pass

func _process(delta):
	time += delta*4
	position.y = start_y + sin(time)*5
	$Shadow.global_position.y = shadow_start_y
	$Shadow.scale = Vector2(1, 1) * (sin(time)/8 + 1.1)
