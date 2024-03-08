extends Control

export var text = "this is a label"
onready var label = $Label

signal done_typing()

func _ready():
	label.connect("done_typing", self, "done_typing")
	label.start_typing(text)
	
func start_typing(next_text):
	label.start_typing(next_text)
	
func done_typing():
	emit_signal("done_typing")

