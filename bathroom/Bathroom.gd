extends StaticBody2D

onready var label = $dialogue
var currently_talking = null
var which_scene = null
var target = null

func _ready():
	$toilet.connect("start_pipe_game", self, "start_pipe_game")
	label.label.add_color_override("font_color", Color("852626"))
	label.start_typing("oh yuck what happened in here")
	for item in get_children():
		if item.get_class() == "StaticBody2D":
			item.connect("update_label", self, "update_label")
		
func update_label(text, obj):
	label.start_typing(text)
	currently_talking = obj
	
func done_typing():
	if currently_talking != null:
		currently_talking.talking = false

func start_pipe_game():
	$Tween.interpolate_property($water, "modulate",
				"ffffff", "00ffffff", 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
#	which_scene = "PIPES"
#	$TransitionScene.visible = true
#	$TransitionScene.transition()
	
func drain_water(pipes):
	target = pipes
	which_scene = "DRAIN"
	$TransitionScene.transition()

func _on_TransitionScene_transitioned():
	match(which_scene):
		"PIPES":
			var pipe_instance = load("res://bathroom/pipe_game.tscn").instance()
			add_child(pipe_instance)
			pipe_instance.connect("drain_water", self, "drain_water")
		"DRAIN":
			target.queue_free()
			$Tween.interpolate_property($water, "modulate",
				"ffffff", "00ffffff", 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		"HALL":
			get_tree().change_scene("res://hall/Hall.tscn")
