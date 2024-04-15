extends Label

var tween: Tween
var fade_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.inner_voice_updated.connect(func(_text: String):
		if _text == text:
			return
		if tween:
			tween.kill()
		visible_ratio = 0
		modulate = Color.WHITE
		text = _text
		tween = create_tween()
		tween.tween_property(self, "visible_ratio", 1.0, 3.0)
		tween.chain().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 3.0)
		await tween.finished
		text = ""
	)
