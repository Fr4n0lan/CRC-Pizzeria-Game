extends CharacterBody2D
class_name Player

@export var SPEED := 200.0
@export var ACCEL := 60
@export var MAX_HEALTH: int = 3

@onready var anim2d = $AnimatedSprite2D
@onready var shootTimer = $ShootTimer

var projectile_preload = preload("res://scenes/projectile.tscn")
var canShoot = true
var health: int

var last_input: Vector2
var input: Vector2
var shootInput: Vector2

func get_input():
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input.normalized()

func get_shoot_input():
	shootInput = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	return	shootInput.normalized()

func _ready() -> void:
	health = MAX_HEALTH
	
func _physics_process(delta: float) -> void:
	var playerInput = get_input()
	var currentShootInput = get_shoot_input()
	var dir := Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)

	move_and_slide()
	last_input = currentShootInput

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot_down") and canShoot:
		var projectile_instance: CharacterBody2D = projectile_preload.instantiate()
		projectile_instance.position = position
		projectile_instance.global_rotation = last_input.angle()
		get_parent().add_child(projectile_instance)
		
		canShoot = false 
		shootTimer.start()
	elif Input.is_action_pressed("shoot_right") and canShoot:
		var projectile_instance: CharacterBody2D = projectile_preload.instantiate()
		projectile_instance.position = position
		projectile_instance.global_rotation = last_input.angle()
		get_parent().add_child(projectile_instance)
		
		canShoot = false 
		shootTimer.start()
	if Input.is_action_pressed("shoot") and canShoot:
		var projectile_instance: CharacterBody2D = projectile_preload.instantiate()
		projectile_instance.position = position
		projectile_instance.global_rotation = last_input.angle()
		get_parent().add_child(projectile_instance)
		
		canShoot = false 
		shootTimer.start()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left"):
		anim2d.play("move_left")
	elif Input.is_action_just_pressed("move_down"):
		anim2d.play("move_down")
	elif Input.is_action_just_pressed("move_up"):
		anim2d.play("move_up")
	elif Input.is_action_just_pressed("move_right"):
		anim2d.play("move_right")
	elif Input.is_action_pressed("shoot_left"):
		anim2d.play("move_left")
		anim2d.stop()
	elif Input.is_action_pressed("shoot_down"):
		anim2d.play("move_down")
		anim2d.stop()
	elif Input.is_action_pressed("shoot_up"):
		anim2d.play("move_up")
		anim2d.stop()
	elif Input.is_action_pressed("shoot_right"):
		anim2d.play("move_right")
		anim2d.stop()

func hit():
	health -= 1
	if health <= 1:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_shoot_timer_timeout() -> void:
	canShoot = true
