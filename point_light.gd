extends PointLight2D

var associated_shot

func assign(shot):
	associated_shot = shot
	
func clear_assigned():
	associated_shot = null

func _process(delta):
	if associated_shot:
		position = Vector2(associated_shot.position.x,associated_shot.position.y+30)
