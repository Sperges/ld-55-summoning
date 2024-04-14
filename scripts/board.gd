extends Node3D


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Topple")


func _on_interactable_interacted():
	$AnimationPlayer.play("topple")
