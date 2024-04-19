extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$light.connect("lights_on", self, "lights_on")
	
func lights_on():
	if $lights_off.visible:
		$lights_off.visible = false
		$trees_two.visible = true
		$portal.can_portal = true
		$dark_window.visible = false
	else:
		$lights_off.visible = true
		$dark_window.visible = true
		$trees_two.visible = false
		$portal.can_portal = false
