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

signal start_cutscene(which_cutscene)
signal start_star_game(star_game)

export (String) var object_name
onready var text_label = $Label
export (String) var idle
export (String) var animated
export (Action) var action = Action.TAKE
export var on_sprite = 0
export var off_sprite = 1
onready var which_sprite = $furniture.get_child(0)
export var frame = 1
export (String) var which_game = Game.STARS
export var unlocked = false

var talking = false

func _ready():
	which_sprite.frame = frame
	text_label.text = object_name
	text_label.visible = false
	
func action():
	match(action):
		Action.TAKE:
			print("you took " + str(object_name))
			queue_free()
		Action.LOOK:
			print("you looked at " + str(object_name))
		Action.LOOK_OUT:
			print("you looked out " + str(object_name))
			var star_instance = load("res://puzzles/star_game.tscn").instance()
			get_parent().add_child(star_instance)
			emit_signal("start_star_game", star_instance)
#			emit_signal("start_cutscene", "waves")
#			match(which_game):
#				Game.STARS:
#					emit_signal("start_star_game")
		Action.OPEN:
			if unlocked:
#				if which_sprite.frame == off_sprite:
#					which_sprite.frame = on_sprite
#				else:
				which_sprite.frame = off_sprite
		Action.TALK:
			if talking == false:
				talking = true
		Action.ONOFF:
			if which_sprite.frame == off_sprite:
				which_sprite.frame = on_sprite
			else:
				which_sprite.frame = off_sprite
func _process(delta):
	if talking:
		if which_sprite.frame == off_sprite:
			which_sprite.frame = on_sprite
		else:
			which_sprite.frame = off_sprite

func _on_TalkTimer_timeout():
	talking = false
