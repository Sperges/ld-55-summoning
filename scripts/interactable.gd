extends Area3D
class_name Interactable

signal hovered
signal interacted(interacter)


@export var one_time := false


var triggered := false


func hover() -> void:
	if one_time:
		if triggered:
			return
	hovered.emit()


func interact(interacter = null) -> void:
	if one_time:
		if triggered:
			return
	triggered = true
	interacted.emit(interacter)
	GameEvents.interact_cue_cleared.emit()
