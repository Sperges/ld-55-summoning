extends Node3D


@export var chamber := "chamber_01"


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("alter maze")


func _on_interactable_interacted():
	GameEvents.map_altered.emit(chamber)
