extends CharacterBody2D
class_name Projectile

@export var SPEED = 320.0
@onready var sprite2d = $Sprite2D
@onready var destroyTimer = $DestroyTimer
var rotDir: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotDir = ((randi()%2)*2-1)
	destroyTimer.start()
	
func _physics_process(delta: float) -> void:	
	if randi_range(1, 2) == 1:
		sprite2d.rotation += 10 * delta * rotDir
	else:
		sprite2d.rotation -= 10 * delta * rotDir
		
	velocity = transform.x * SPEED * delta
	
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider is Enemy:
			collider.hit()
			queue_free()



func _on_destroy_timer_timeout() -> void:
	queue_free()
