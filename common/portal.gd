extends Node2D

export (PackedScene) var going_to 
export (PackedScene) var coming_from 

var can_portal = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and can_portal:
		$TransitionScene.visible = true
		$TransitionScene.transition()

func _on_TransitionScene_transitioned():
	get_tree().change_scene_to(going_to)
