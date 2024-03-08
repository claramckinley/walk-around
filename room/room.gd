extends Node2D

func _ready():
#	$interactable.connect("start_cutscene", self, "on_cutscene")
	$window.connect("start_star_game", self, "start_star_game")
	pass
	
func start_star_game(star_instance):
	star_instance.connect("unlock_trapdoor", self, "unlock_trapdoor")
	
func on_cutscene(which_cutscene):
	$Cutscene.play(which_cutscene)

func unlock_trapdoor():
	$trapdoor.unlocked = true
