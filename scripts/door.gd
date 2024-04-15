extends Node3D


var open = false
@export var animation_player: AnimationPlayer
@export var audio_player: AudioStreamPlayer3D


func _on_interactable_hovered():
	if not open:
		GameEvents.interact_cue_updated.emit("Open")


func _on_interactable_interacted(interacter):
	if not open:
		$AudioStreamPlayer.play()
		open = true
		animation_player.play("open")
		audio_player.play()
		GameEvents.cinematic_triggered.emit("maze_gate")
		GameEvents.camera_traumaed.emit(0.1, 3.0)
