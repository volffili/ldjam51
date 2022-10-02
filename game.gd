extends Node2D

var enemy_scene = preload("res://enemy.tscn")
var bg_tile_scene = preload("res://bg_tile.tscn")
var wall_tile_scene = preload("res://wall_tile.tscn")
var black_hole_scene = preload("res://upgrades/black_hole.tscn")
var chain_scene = preload("res://upgrades/chain.tscn")
var charge_up_scene = preload("res://upgrades/charge_up.tscn")
var damage_scene = preload("res://upgrades/damage.tscn")
var explode_scene = preload("res://upgrades/explode.tscn")
var fire_dot_scene = preload("res://upgrades/fire_dot.tscn")
var fire_rate_scene = preload("res://upgrades/fire_rate.tscn")
var freeze_scene = preload("res://upgrades/freeze.tscn")
var impact_scene = preload("res://upgrades/impact.tscn")
var mouse_homing_scene = preload("res://upgrades/mouse_homing.tscn")
var piercing_scene = preload("res://upgrades/piercing.tscn")
var speed_scene = preload("res://upgrades/speed.tscn")
var triple_shot_scene = preload("res://upgrades/triple_shot.tscn")

@onready var spawn_timer = Timer.new()
@onready var upgrade_timer = Timer.new()
const map_size = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 1.0
	spawn_timer.connect("timeout", self.spawn)
	add_child(spawn_timer)
	spawn_timer.start()
	
	upgrade_timer.one_shot = false
	upgrade_timer.wait_time = 10.0
	upgrade_timer.connect("timeout", self.spawn_upgrades)
	add_child(upgrade_timer)
	upgrade_timer.start()
	
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
	add_child(enemy)
	for i in range(20):
		enemy.global_position = $player.global_position + Vector2.from_angle(randf()*2*PI) * 500
		if -map_size * 100 < enemy.global_position.x and enemy.global_position.x < map_size * 100 and -map_size * 100 < enemy.global_position.y and enemy.global_position.y < map_size * 100:
			break

var upgrades = [
	black_hole_scene,
	chain_scene,
	charge_up_scene,
	damage_scene,
	explode_scene,
	fire_dot_scene,
	fire_rate_scene,
	freeze_scene,
	impact_scene,
	mouse_homing_scene,
	piercing_scene,
	speed_scene,
	triple_shot_scene,
	###
	damage_scene,
	damage_scene,
	speed_scene,
	explode_scene,
	fire_dot_scene,
]
func random_upgrade():
	return upgrades[randi() % len(upgrades)].instantiate()

func spawn_upgrades():
	var u1 = random_upgrade()
	add_child(u1)
	u1.position = $player.position + Vector2(-50, -100)
	
	var u2 = random_upgrade()
	add_child(u2)
	u2.position = $player.position + Vector2(50, -100)
	print($player.global_position, u1.global_position, u2.global_position)
	
	u1.other_upgrade = u2
	u2.other_upgrade = u1
