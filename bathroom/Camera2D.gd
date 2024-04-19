extends Camera2D

export var speed = 10;
export var move_camera = false
export var stop_camera_at = 512
var velocity = Vector2.ZERO

#func _physics_process(delta):
#	if move_camera and position.x <= stop_camera_at:
#		velocity.x += 1;
#		velocity.x = velocity.x * speed;
#		position.x += velocity.x * delta;
