extends Node2D


var size = 100
	
	
var textures = [ 
	preload("res://sprites/leafs1.png"),
	preload("res://sprites/leafs2.png"),
	preload("res://sprites/leafs3.png"),
	preload("res://sprites/bones.png")
]

func _ready():
	var tiles = [$Bg1,$Bg2,$Bg3,$Bg4,$Bg5,$Bg6,$Bg7,$Bg8,$Bg9,$Bg10,$Bg11,$Bg12,$Bg13,$Bg14,$Bg15,$Bg16]
	$tree.position = Vector2(randi_range(-size/2.0, size/2.0), randi_range(-size/2.0, size/2.0))
	for tile in tiles:
		tile.flip_h = randi()%2
		tile.flip_v = randi()%2
		tile.set_texture(textures[randi()%4])
		tile.modulate = Color(0.4+randf()/4, 0.4+randf()/4, 0.4+randf()/4)
