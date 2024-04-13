extends Area3D
class_name Interactable

signal hovered
signal interacted


func hover() -> void:
	hovered.emit()


func interact() -> void:
	interacted.emit()
	GameEvents.interact_cue_cleared.emit()
