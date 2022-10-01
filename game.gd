extends Node2D

var enemy_scene = preload("res://enemy.tscn")

@onready var spawn_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 1.0
	spawn_timer.connect("timeout", self.spawn)
	add_child(spawn_timer)
	spawn_timer.start()

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func spawn():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = $player.global_position + Vector2.from_angle(randf()*2*PI) * 500
	add_child(enemy)
