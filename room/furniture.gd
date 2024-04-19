extends Node2D


export var frame = 0

signal lights_on()

func _ready():
	$furniture.frame = frame

func action():
	emit_signal("lights_on")
