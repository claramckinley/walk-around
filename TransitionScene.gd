extends CanvasLayer

signal transitioned()

func transition():
	$AnimationPlayer.play("fade_to_black")
	
func fade_to_normal():
	$AnimationPlayer.play("fade_to_normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
