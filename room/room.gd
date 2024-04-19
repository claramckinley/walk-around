extends Node2D

onready var label = $dialogue
var currently_talking = null
var which_scene

func _ready():
	label.label.add_color_override("font_color", Color("9ba5d3"))
#	$interactable.connect("start_cutscene", self, "on_cutscene")
	$window.connect("start_star_game", self, "start_star_game")
	$trapdoor.connect("go_to_hall", self, "go_to_hall")
	label.connect("done_typing", self, "done_typing")
	for item in get_children():
		if item.get_class() == "StaticBody2D":
			item.connect("update_label", self, "update_label")
	label.start_typing("wow its already nighttime")
		
func update_label(text, obj):
	label.start_typing(text)
	currently_talking = obj
	
func done_typing():
	if currently_talking != null:
		currently_talking.talking = false
	
func start_star_game():
	which_scene = "STARS"
	$TransitionScene.visible = true
	$TransitionScene.transition()

func go_to_hall():
	which_scene = "HALL"
	$TransitionScene.visible = true
	$TransitionScene.transition()
	
func on_cutscene(which_cutscene):
	$Cutscene.play(which_cutscene)

func unlock_trapdoor():
	$key.position.x = 550
	$key.position.y = 400
	$trapdoor.unlocked = true

func _on_TransitionScene_transitioned():
	match(which_scene):
		"STARS":
			var star_instance = load("res://puzzles/star_game.tscn").instance()
			add_child(star_instance)
			star_instance.connect("unlock_trapdoor", self, "unlock_trapdoor")
		"HALL":
			get_tree().change_scene("res://hall/Hall.tscn")
