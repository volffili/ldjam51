extends Node2D

var enemy_scene = preload("res://enemy.tscn")
var bg_tile_scene = preload("res://bg_tile.tscn")
var wall_tile_scene = preload("res://wall_tile.tscn")

@onready var spawn_timer = Timer.new()
const map_size = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 1.0
	spawn_timer.connect("timeout", self.spawn)
	add_child(spawn_timer)
	spawn_timer.start()
	
	for i in range(-map_size, map_size):
		for j in range(-map_size, map_size):
			var bg_tile
			if i == -map_size or i == map_size-1 or j == -map_size or j == map_size-1:
				bg_tile = wall_tile_scene.instantiate()
			else:
				bg_tile = bg_tile_scene.instantiate()
			bg_tile.position = Vector2(i * 100, j * 100)
			add_child(bg_tile)

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func spawn():
	var enemy = enemy_scene.instantiate()
	for i in range(20):
		enemy.global_position = $player.global_position + Vector2.from_angle(randf()*2*PI) * 500
		if -map_size * 100 < enemy.global_position.x and enemy.global_position.x < map_size * 100 and -map_size * 100 < enemy.global_position.y and enemy.global_position.y < map_size * 100:
			break
	add_child(enemy)

