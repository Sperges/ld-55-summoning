extends Node3D


@export var animation_player: AnimationPlayer


func _ready() -> void:
	GameEvents.map_altered.connect(_on_map_altered)


func _on_map_altered(state: String) -> void:
	animation_player.play(state)
	if state == "blood":
		$BloodPlayer.play()
		GameEvents.camera_traumaed.emit(0.1, 7.0)
		await animation_player.animation_finished
		animation_player.play("summon")
		GameEvents.camera_traumaed.emit(0.3, 5.0)
		await animation_player.animation_finished
		animation_player.play("summon_idle")
		GameEvents.camera_traumaed.emit(0.1, 15.0)
		await get_tree().create_timer(15).timeout
		Globals.player.die()
		await get_tree().create_timer(1.9).timeout
		get_tree().change_scene_to_file("res://scenes/ui/end.tscn")
	else:
		GameEvents.camera_traumaed.emit(0.1, 7.0)
		$TurningPlayer.play()
