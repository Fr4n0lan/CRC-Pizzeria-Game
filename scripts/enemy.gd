extends CharacterBody2D
class_name Enemy

@export var SPEED = 75.0

var player_pos: Vector2
var chase_dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	chase_dir = updatePlayerPos() - position
	velocity = chase_dir.normalized() * SPEED * delta
	
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			collider.hit()

func updatePlayerPos() -> Vector2:
	player_pos = get_tree().get_nodes_in_group("player")[0].position
	return player_pos

func hit():
	queue_free()
