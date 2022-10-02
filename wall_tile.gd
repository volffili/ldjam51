extends Node2D

var tree_scene = preload("res://tree_no_collision.tscn")

func _ready():
	var size = $Bg.texture.get_width() * $Bg.scale.x
	for i in range(20):
		var tree = tree_scene.instantiate()
		tree.position = Vector2(randi_range(-size/2.0, size/2.0), randi_range(-size/2.0, size/2.0))
		add_child(tree)
