extends Node3D


@export var chamber := "chamber_01"

var spin1: Vector3 = Vector3.ZERO
var spin2: Vector3 = Vector3.ZERO


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Alter maze")


func _on_interactable_interacted():
	GameEvents.map_altered.emit(chamber)


func _ready():
	spin1 = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1))
	spin2 = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1))


func _physics_process(delta):
	$Inner.rotate_x(spin1.x * delta)
	$Inner.rotate_y(spin1.y * delta)
	$Inner.rotate_z(spin1.z * delta)
	$Outer.rotate_x(spin2.x * delta)
	$Outer.rotate_y(spin2.y * delta)
	$Outer.rotate_z(spin2.z * delta)
