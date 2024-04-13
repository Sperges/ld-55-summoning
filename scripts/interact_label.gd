extends Label

func _ready() -> void:
	GameEvents.interact_cue_updated.connect(_on_interact_cue_updated)
	GameEvents.interact_cue_cleared.connect(_on_interact_cue_cleared)


func _on_interact_cue_updated(str: String) -> void:
	text = str


func _on_interact_cue_cleared() -> void:
	text = ""
