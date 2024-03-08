extends Node

enum Action {
	TAKE,
	LOOK,
	LOOK_OUT,
	OPEN,
	ONOFF,
	TALK
}

enum Game{
	STARS
}

signal start_star_game()
signal update_label(text, object)

onready var text_label = $Label
export (Action) var action_type = Action.TAKE
export var on_sprite = 0
export var off_sprite = 1
onready var which_sprite = $furniture.get_child(0)
export (int) var frame
export var unlocked = false
export var text = "this is fresh text"

var talking = false
var signaled = false

func _ready():
	which_sprite.frame = frame
	text_label.visible = false
	
func action():
	match(action_type):
		Action.TAKE:
			self.visible = false
#		Action.LOOK:
#			print("you looked at " + str(object_name))
		Action.LOOK_OUT:
			emit_signal("start_star_game")
		Action.OPEN:
			if unlocked:
				which_sprite.frame = off_sprite
		Action.TALK:
			$TalkAnimationTimer.start()
		Action.ONOFF:
			if which_sprite.frame == off_sprite:
				which_sprite.frame = on_sprite
			else:
				which_sprite.frame = off_sprite
	if !signaled:
		$TalkTimer.start()
		if which_sprite.frame == off_sprite:
			emit_signal("update_label", text, self)
		signaled = true

func _on_TalkTimer_timeout():
	$TalkTimer.stop()
	$TalkAnimationTimer.stop()
	if action_type == Action.TALK:
		which_sprite.frame = off_sprite
		if self != null:
			talking = false
			signaled = false

func _on_TalkAnimationTimer_timeout():
	if which_sprite.frame == off_sprite:
		which_sprite.frame = on_sprite
	else:
		which_sprite.frame = off_sprite
