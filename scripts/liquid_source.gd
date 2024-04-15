extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Take")



func _on_interactable_interacted(interacter):
	print(interacter)
	if interacter is Hand:
		interacter.has_liquid = true
	else:
		GameEvents.inner_voice_updated.emit("I dare not touch it with mortal hands...")
	
