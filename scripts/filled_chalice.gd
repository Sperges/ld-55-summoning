extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Fill")

func _on_interactable_interacted(interacter):
	print("interacted")
	if interacter is Hand and interacter.has_liquid:
		print("hand")
		$Interactable.one_time = true
		$Interactable.triggered = true
		$Liquid.visible = true
		$AudioStreamPlayer.play()
		GameEvents.map_altered.emit("chamber_02")
	else:
		GameEvents.inner_voice_updated.emit("If only to fill it with that profane liquid.")
