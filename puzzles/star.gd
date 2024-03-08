extends Node2D


onready var animation = $AnimatedSprite
var frame = 0
var locked = false

signal clicked(which_star, locked)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	frame = rand_range(0, 6)
	animation.frame = frame
#	$AnimationPlayer.play("stars")
	
func _on_Area2D_mouse_entered():
	if !locked:
		animation.animation = "stars_focused"
		animation.frame = frame

func _on_Area2D_mouse_exited():
	if !locked:
		animation.animation = "stars"
		animation.frame = frame


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
		if !locked:
			locked = true
			emit_signal("clicked", self, true)
		else:
			locked = false
			emit_signal("clicked", self, false)
	
