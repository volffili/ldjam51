extends Node2D

var enemy_scene = preload("res://enemy.tscn")
var enemy_tank_scene = preload("res://enemy_tank.tscn")
var enemy_charger_scene = preload("res://enemy_charger.tscn")
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

@export @onready var spawn_timer = Timer.new()
@export @onready var upgrade_timer = Timer.new()
@export @onready var tank_timer = Timer.new()
@export @onready var charger_timer = Timer.new()
const map_size = 8
var should_split = false
var hp_mul = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in range(-map_size, map_size):
		for j in range(-map_size, map_size):
			var bg_tile
			if i == -map_size or i == map_size-1 or j == -map_size or j == map_size-1:
				bg_tile = wall_tile_scene.instantiate()
			else:
				bg_tile = bg_tile_scene.instantiate()
			bg_tile.position = Vector2(i * 100, j * 100)
			add_child(bg_tile)

func _on_play_pressed():
	$HUD/Intro.visible = false
	
	$AnimationPlayer.play("start")
	$AudioStreamPlayer.play()

	spawn_timer.one_shot = false
	spawn_timer.wait_time = 2.0
	spawn_timer.connect("timeout", self.spawn)
	add_child(spawn_timer)
	spawn_timer.start()

	upgrade_timer.one_shot = false
	upgrade_timer.wait_time = 10.0
	upgrade_timer.connect("timeout", self.spawn_upgrades)
	add_child(upgrade_timer)
	upgrade_timer.start()
	upgrade_timer.wait_time = 20.0

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func spawn():
	var enemy = enemy_scene.instantiate()
	enemy.should_split = should_split
	enemy.hp *= hp_mul
	add_child(enemy)
	for i in range(20):
		enemy.global_position = $player.global_position + Vector2.from_angle(randf()*2*PI) * 500
		if -map_size * 100 < enemy.global_position.x and enemy.global_position.x < map_size * 100 and -map_size * 100 < enemy.global_position.y and enemy.global_position.y < map_size * 100:
			break

func tank_spawn():
	var enemy = enemy_tank_scene.instantiate()
	enemy.hp *= hp_mul
	add_child(enemy)
	for i in range(20):
		enemy.global_position = $player.global_position + Vector2.from_angle(randf()*2*PI) * 500
		if -map_size * 100 < enemy.global_position.x and enemy.global_position.x < map_size * 100 and -map_size * 100 < enemy.global_position.y and enemy.global_position.y < map_size * 100:
			break
			
func charger_spawn():
	var enemy = enemy_charger_scene.instantiate()
	enemy.hp *= hp_mul
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
	explode_scene,
	fire_dot_scene,
	speed_scene,
	speed_scene,
]
func random_upgrade(other=null):
	var u
	for i in range(5):
		u = upgrades[randi() % len(upgrades)]
		if u == other:
			continue
		if (u == piercing_scene and len(get_tree().get_nodes_in_group("bounce"))) or \
			(u == freeze_scene and len(get_tree().get_nodes_in_group("freeze"))) or \
			(u == charge_up_scene and len(get_tree().get_nodes_in_group("charge_up"))) or \
			(u == mouse_homing_scene and len(get_tree().get_nodes_in_group("homing"))):
			continue
		return u
	return u

func spawn_upgrades():
	$HUD.show_text("Choose an Upgrade", "")
	upgrade_timer.wait_time = 20.0
	
	var u1_scene = random_upgrade()
	var u1 = u1_scene.instantiate()
	u1.position = $player.position + Vector2(-50, -100)
	u1.position.x = max(u1.position.x, -map_size * 100 + 80)
	u1.position.y = max(u1.position.y, -map_size * 100 + 80)
	add_child(u1)
	
	var u2_scene = random_upgrade(u1_scene)
	var u2 = u2_scene.instantiate()
	u2.position = $player.position + Vector2(50, -100)
	u2.position.x = min(u2.position.x, map_size * 100 - 170)
	u2.position.y = max(u2.position.y, -map_size * 100 + 80)
	add_child(u2)
	
	u1.other_upgrade = u2
	u2.other_upgrade = u1

func start_tank_spawn():
	$HUD.show_text("Guardians Spawn", "Enemy Upgrade", Color.ORANGE_RED)
	tank_timer.one_shot = false
	tank_timer.wait_time = 5.0
	tank_timer.connect("timeout", self.tank_spawn)
	add_child(tank_timer)
	tank_timer.start()
	
func start_charger_spawn():
	$HUD.show_text("Chargers Spawn", "Enemy Upgrade", Color.ORANGE_RED)
	charger_timer.one_shot = false
	charger_timer.wait_time = 4.0
	charger_timer.connect("timeout", self.charger_spawn)
	add_child(charger_timer)
	charger_timer.start()
	
func double_spawn_rate():
	$HUD.show_text("More Slimes", "Enemy Upgrade", Color.ORANGE_RED)
	spawn_timer.wait_time /= 2.0
	
func double_tank_spawn_rate():
	$HUD.show_text("More Guardians", "Enemy Upgrade", Color.ORANGE_RED)
	tank_timer.wait_time /= 2.0
	
func triple_charger_spawn_rate():
	$HUD.show_text("More Chargers", "Enemy Upgrade", Color.ORANGE_RED)
	charger_timer.wait_time /= 3.0
	
func enable_splitting():
	$HUD.show_text("Slimes Split", "Enemy Upgrade", Color.ORANGE_RED)
	should_split = true
	
func increase_hp():
	$HUD.show_text("Higher Health", "Enemy Upgrade", Color.ORANGE_RED)
	hp_mul *= 1.5

func slime_ambush():
	$HUD.show_text("Slime Ambush", "Enemy Upgrade", Color.ORANGE_RED)	
	for i in range(40):
		spawn()

func big_ambush():
	$HUD.show_text("Slime Ambush", "Enemy Upgrade", Color.ORANGE_RED)	
	for i in range(60):
		spawn()
	for i in range(10):
		tank_spawn()
	for i in range(10):
		charger_spawn()
		
func biggest_ambush():
	$HUD.show_text("Slime Ambush", "Enemy Upgrade", Color.ORANGE_RED)	
	for i in range(100):
		spawn()
	for i in range(30):
		tank_spawn()
	for i in range(30):
		charger_spawn()

func win():
	$HUD.win()
	spawn_timer.stop()
	tank_timer.stop()
	charger_timer.stop()
	upgrade_timer.stop()
	for e in get_tree().get_nodes_in_group("enemy"):
		e.queue_free()
