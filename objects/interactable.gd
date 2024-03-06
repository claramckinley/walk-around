extends Node

enum Action {
	TAKE,
	LOOK,
	OPEN
}

export (String) var object_name
onready var text_label = $Label
export (String) var idle
export (String) var animated
export (Action) var action = Action.TAKE
onready var animation_player = $Sprite

func _ready():
	animation_player.play(idle)
	text_label.text = object_name
	text_label.visible = false
	animation_player.connect("animation_finished", self, "set_to_idle")

func set_to_idle():
	if(animation_player.animation != idle):
		animation_player.play(idle)
	
func action():
	match(action):
		Action.TAKE:
			print("you took " + str(object_name))
			queue_free()
		Action.LOOK:
			print("you looked at " + str(object_name))
		Action.OPEN:
			print("you opened " + str(object_name))
	play_animation()

func play_animation():
	animation_player.play(animated)
