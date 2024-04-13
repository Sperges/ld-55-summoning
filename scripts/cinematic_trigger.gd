extends Node3D
class_name CinematicTrigger


@export var animation_name: String

var triggered := false


func _on_area_3d_body_entered(body):
	if body is Player and not triggered:
		triggered = true
		print("trigger: ", animation_name)
		GameEvents.cinematic_triggered.emit(animation_name)
