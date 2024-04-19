extends Node

enum Action {
	TAKE,
	LOOK,
	LOOK_OUT,
	OPEN,
	ONOFF,
	TALK,
	LOOK_AT_PIPES
}

enum Game{
	STARS
}

enum ROOM {
	BEDROOM,
	HALL,
	BATHROOM,
	YARD
}

signal start_star_game()
signal start_pipe_game()
signal update_label(text, object)
signal go_to_hall()

onready var text_label = $Label
export (Action) var action_type = Action.TAKE
export var on_sprite = 0
export var off_sprite = 1
onready var which_sprite
export (int) var frame
export var unlocked = false
export var text = "this is fresh text"
export (ROOM) var which_room
export var remove_collision = false

var talking = false
var signaled = false

func _ready():
	for sprite in get_children():
		if sprite.get_class() == "AnimatedSprite":
			sprite.visible = false
	match(which_room):
		ROOM.BEDROOM:
			$bedroom.visible = true
			which_sprite = $bedroom
		ROOM.HALL:
			$hall.visible = true
			which_sprite = $hall
		ROOM.BATHROOM:
			$bathroom.visible = true
			which_sprite = $bathroom
		ROOM.YARD:
			$yard.visible = true
			which_sprite = $yard
	which_sprite.frame = frame
	text_label.visible = false
#	if remove_collision:
#		$CollisionShape2D.queue_free()
	
func action():
	match(action_type):
		Action.TAKE:
			self.visible = false
#		Action.LOOK:
#			print("you looked at " + str(object_name))
		Action.LOOK_OUT:
			emit_signal("start_star_game")
		Action.LOOK_AT_PIPES:
			emit_signal("start_pipe_game")
		Action.OPEN:
			if unlocked:
				which_sprite.frame = off_sprite
				handle_trapdoor()
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
		
func handle_trapdoor():
	if which_sprite.frame == 11:
		emit_signal("go_to_hall")

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
