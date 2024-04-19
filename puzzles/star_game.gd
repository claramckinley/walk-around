extends Node2D


var answer = []
var player_answer = []
var signal_emitted = false

onready var star_collection = $star_collection

signal unlock_trapdoor

func _ready():
	answer = star_collection.get_children()
	for item in answer:
		item.connect("clicked", self, "star_clicked")
	
func star_clicked(which_star, locked):
	if locked:
		player_answer.append(which_star)
		check_answer()
	else:
		player_answer.erase(which_star)
	
func check_answer():
	if answer.size() == player_answer.size():
		if check_equality():
			$StarTimer.start()
			
func check_equality():
	for star in answer:
		if !player_answer.has(star):
			return false
	return true
	

func _on_Button_pressed():
	queue_free()

func _on_StarTimer_timeout():
	for star in answer:
		if star.animation.animation == "stars":
			star.animation.animation = "stars_focused"
			star.animation.frame = star.frame
		else:
			star.animation.animation = "stars"
			star.animation.frame = star.frame
	if !signal_emitted:
		emit_signal("unlock_trapdoor")
		signal_emitted = true
