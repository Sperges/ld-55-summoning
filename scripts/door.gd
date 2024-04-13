extends Node3D


var open = false
@export var animation_player: AnimationPlayer
@export var audio_player: AudioStreamPlayer3D


func _on_interactable_hovered():
	if not open:
		GameEvents.interact_cue_updated.emit("open")


func _on_interactable_interacted():
	if not open:
		open = true
		animation_player.play("open")
		audio_player.play()
