extends Node3D


func _ready():
	GameEvents.cinematic_triggered.emit("game_start")
	pass


func _input(event):
	if Input.is_action_just_pressed("toggle_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
