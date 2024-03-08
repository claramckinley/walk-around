extends Label

var pc: float
onready var timer = $"../Timer"
onready var clear_timer = $"../clearTimer"

signal done_typing()

var next_text = "placeholder text"
		
func start_typing(next_text):
	text = next_text
	visible_characters = 0
	if text.length() > 0:
		pc = 1.0 / text.length() # percent to add to the label each time the timer times out - with 150 characters this will give you 0.006667 per update, enough for 1 character per update.
		timer.start()

func _on_Timer_timeout():
	visible_characters += 1
	if visible_characters == text.length():
		timer.stop()
		clear_timer.start()

func _on_clearTimer_timeout():
	visible_characters = 0
	$"../clearTimer".stop()
	emit_signal("done_typing")
	
