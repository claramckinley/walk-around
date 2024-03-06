extends StaticBody2D


export var frame = 0

func _ready():
	$furniture.frame = frame
	if frame == 2:
		$CollisionShape2D.queue_free()
