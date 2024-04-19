extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var acc = 100
var speed = 100
var friction = 500
var can_interact = false
var target = null
onready var sprite = $AnimatedSprite
onready var timer = $InteractTimer

func _process(delta):
	var input_x_axis = Input.get_axis("move_left", "move_right")
	var input_y_axis = Input.get_axis("move_up", "move_down")
	handle_acc(input_x_axis, input_y_axis, delta)
	apply_friction(input_x_axis, input_y_axis, delta)
	if can_interact and Input.is_action_pressed("use"):
		check_interact()
	if Input.is_action_pressed("inventory"):
		open_inventory()
	
func handle_acc(input_x_axis, input_y_axis, delta):
	if input_x_axis != 0:
		velocity.x = move_toward(velocity.x, speed * input_x_axis, acc * delta)
		if input_y_axis == 0:
			if velocity.x > 0:
				sprite.play("right")
			else:
				sprite.play("left")
	if input_y_axis != 0:
		velocity.y = move_toward(velocity.y, speed * input_y_axis, acc * delta)
		if velocity.y > 0:
			sprite.play("right")
		else:
			sprite.play("left")
#			sprite.play("down")
#		else:
#			sprite.play("up")
	move_and_slide(velocity)
	
func apply_friction(input_x_axis, input_y_axis, delta):
	if input_x_axis == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		if sprite.animation == "right":
			sprite.play("right")
		if sprite.animation == "left":
			sprite.play("left")
	if input_y_axis == 0:
		velocity.y = move_toward(velocity.y, 0, friction * delta)
#		if sprite.animation == "up":
#			sprite.play("idleup")
#		if sprite.animation == "down":
#			sprite.play("idledown")
	move_and_slide(velocity)
	
func check_interact():
	if target != null:
		can_interact = false
		timer.start()
#		if PlayerData.inventory.has(target.object_name):
#			var curr_num = PlayerData.inventory[target.object_name]
#			PlayerData.inventory[target.object_name] = curr_num + 1
#		else:
#			PlayerData.inventory[target.object_name] = 1
		target.action()

func open_inventory():
	$inventory.show()
	get_tree().paused = true

func _on_Area2D_area_entered(area):
	if area.is_in_group("object"):
		target = area.get_parent()
		can_interact = true


func _on_Area2D_area_exited(area):
	if area.is_in_group("object"):
		if area.get_parent() == target:
			can_interact = false
			target = null


func _on_InteractTimer_timeout():
	can_interact = true
