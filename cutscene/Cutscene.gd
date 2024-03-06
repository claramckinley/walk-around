extends Node2D

export var which_animation = "waves"
onready var animation_player = $AnimationPlayer
onready var wave_timer = $WaveTimer

func _ready():
	animation_player.connect("animation_finished", self, "finished_cutscene")
	play()

func play():
	get_tree().paused = true
	visible = true
	wave_timer.start()
	
func finished_cutscene(animation):
	get_tree().paused = false
	visible = false


func _on_WaveTimer_timeout():
	finished_cutscene("waves")
