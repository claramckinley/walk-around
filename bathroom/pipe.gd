extends Sprite

export var direction = "NONE"
export var answer = []
var is_correct = false

signal check_answer()

func _ready():
	rotate_pipe()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
		rotate_pipe()
		
func rotate_pipe():
	match(direction):
		"POS_ONE":
			direction ="POS_TWO"
			rotation_degrees = 0
		"POS_TWO":
			direction = "POS_THREE"
			rotation_degrees = 90
		"POS_THREE":
			direction = "POS_FOUR"
			rotation_degrees = 180
		"POS_FOUR":
			direction = "POS_ONE"
			rotation_degrees = 270
	if answer.has(direction):
		self.is_correct = true
#		print("correct " + str(self))
		emit_signal("check_answer")
	else:
		is_correct = false
