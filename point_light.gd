extends PointLight2D

var associated_shot

func _ready():
	scale = Vector2(0.25,0.125)

func assign(shot):
	associated_shot = shot
	position = Vector2(associated_shot.position.x,associated_shot.position.y+20)
	color = shot.modulate
	
func clear_assigned():
	associated_shot = null

func _process(delta):
	if associated_shot:
		position = Vector2(associated_shot.position.x,associated_shot.position.y+20)

func _physics_process(delta):
	scale = Vector2(0.25,0.125)*(0.875+randf()/4)

func die():
	$AnimationPlayer.play("die")
