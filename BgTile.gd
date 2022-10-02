extends Node2D

func _ready():
	var size = $Bg.texture.get_width() * $Bg.scale.x
	$tree.position = Vector2(randi_range(-size/2.0, size/2.0), randi_range(-size/2.0, size/2.0))
