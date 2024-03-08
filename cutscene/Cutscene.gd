extends Node2D

export var which_animation = "waves"
onready var animation_player = $AnimationPlayer
onready var wave_timer = $WaveTimer

func _ready():
	animation_player.connect("animation_finished", self, "finished_cutscene")

func play(which_cutscene):
	get_tree().paused = true
	visible = true
	animation_player.playback_speed = 5
	animation_player.play(which_cutscene)
	wave_timer.start()
	
func finished_cutscene(_animation):
	get_tree().paused = false
	visible = false


func _on_WaveTimer_timeout():
	finished_cutscene("waves")
