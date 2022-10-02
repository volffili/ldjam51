extends Node2D

@onready
var root = get_node("root")
@onready
var treetop = get_node("treetop")
var root_sprites = [preload("res://sprites/tree/root1.png"),preload("res://sprites/tree/root2.png"),preload("res://sprites/tree/root3.png")]
var treetop_sprites = [preload("res://sprites/tree/treetop1.png"),preload("res://sprites/tree/treetop2.png"),preload("res://sprites/tree/treetop3.png")]

func _ready():
	root.set_texture(root_sprites[randi()%3])
	treetop.set_texture(treetop_sprites[randi()%3])
	treetop.flip_h = randi()%2
	root.flip_h = randi()%2
	scale = Vector2(1,1)*(randf()/2.0+1.5)
