extends Node3D



func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Summon")


func _on_interactable_interacted(interacter):
	Globals.goat.queue_free()
	GameEvents.inner_voice_updated.emit("El la abismo mi vokas vin. leviĝu kaj faru ĥaoson inter ĉi tiu Tero.")
	await get_tree().create_timer(5).timeout
	GameEvents.map_altered.emit("final_spin")
	GameEvents.cinematic_triggered.emit("final_summon")
