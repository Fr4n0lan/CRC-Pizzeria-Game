extends Node2D

var spawners: Array
var enemy_preload = preload("res://scenes/enemy.tscn")
var spawnTime: float = 2.0
var sec = Time.get_ticks_msec()
@onready var spawnDelay: Timer = $SpawnDelay

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if sec >= 0:
		sec = Time.get_ticks_msec()/1000
		spawnTime = abs(sqrt(sec)/10 - 2)
	
func _on_spawn_delay_timeout() -> void:
	var enemy_instance: CharacterBody2D = enemy_preload.instantiate()
	enemy_instance.position = Vector2(randf_range(-250.0, 250.0), randf_range(-100.0, 100.0)).normalized() * 360
	get_parent().add_child(enemy_instance)
	spawnDelay.wait_time = spawnTime
	
