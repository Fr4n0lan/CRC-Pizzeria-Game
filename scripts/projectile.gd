extends RigidBody2D
class_name Projectile

@export var SPEED = 160.0
@onready var sprite2d = $Sprite2D
var rotDir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotDir = ((randi()%2)*2-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = Vector2(4, 4)
	if randi_range(1, 2) == 1:
		sprite2d.rotation += 10 * delta * rotDir
	else:
		sprite2d.rotation -= 10 * delta * rotDir
	global_position += transform.x * SPEED * delta
