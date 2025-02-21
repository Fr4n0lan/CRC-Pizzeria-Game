extends CharacterBody2D
class_name Player

@export var SPEED := 300.0
@export var ACCEL := 60

@onready var anim2d = $AnimatedSprite2D
@onready var shootTimer = $ShootTimer

var projectile_preload = preload("res://scenes/projectile.tscn")
var canShoot = true

var last_input: Vector2
var input: Vector2

func get_input():
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input.normalized()

func _physics_process(delta: float) -> void:
	var playerInput = get_input()
	var dir := Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)

	move_and_slide()

	last_input = get_input()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and canShoot:
		var projectile_instance: RigidBody2D = projectile_preload.instantiate()
		projectile_instance.position = position
		projectile_instance.global_rotation = last_input.angle()
		get_parent().add_child(projectile_instance)
		
		canShoot = false 
		shootTimer.start()

func _on_shoot_timer_timeout() -> void:
	canShoot = true
