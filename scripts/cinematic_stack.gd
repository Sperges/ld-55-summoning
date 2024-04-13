extends Node3D
class_name CinematicStack


@export var player: Player
@export var animation_player: AnimationPlayer
@export var camera: Camera3D


func _ready() -> void:
	GameEvents.cinematic_triggered.connect(_on_cinematic_triggered)
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_cinematic_triggered(label: String) -> void:
	camera.current = true
	player.paused = true
	animation_player.play(label)


func _on_animation_finished(_anim_name: String) -> void:
	player.camera.current = true
	player.paused = false
