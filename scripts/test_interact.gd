extends Node3D


func _on_interactable_interacted(interacter):
	print("hello")


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("interact")
