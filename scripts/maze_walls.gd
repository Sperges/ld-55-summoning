extends Node3D


@export var animation_player: AnimationPlayer
@export var audio_player: AudioStreamPlayer


func _ready() -> void:
	GameEvents.map_altered.connect(_on_map_altered)


func _on_map_altered(state: String) -> void:
	animation_player.play(state)
	audio_player.play()
