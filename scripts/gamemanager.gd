extends Node2D

var spawners: Array
var enemy_preload = preload("res://scenes/enemy.tscn")

@onready var spawnDelay: Timer = $SpawnDelay

func _ready() -> void:
	for i in get_parent().get_node("Spawners").get_children():
		spawners.append(i)

func _process(delta: float) -> void:
	pass

func _on_spawn_delay_timeout() -> void:
	var enemy_instance: CharacterBody2D = enemy_preload.instantiate()
	enemy_instance.position = spawners[randi_range(0, len(spawners) - 1)].position
	get_parent().add_child(enemy_instance)
	
	
