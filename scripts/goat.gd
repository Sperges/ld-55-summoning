extends CharacterBody3D
class_name Goat

const bleat_times = [8, 13, 21, 34, 55]

@export var player: Player
@export var min_player_distance: float = 2.0
@export var activate_distance: float = 10.0
@export var active: bool = false
@export var move_speed: float = 0.5
@export var turn_speed: float = 2.0
@export var audio_player: AudioStreamPlayer3D


func _ready() -> void:
	Globals.goat = self
	_create_bleat_timer()


func _physics_process(delta: float) -> void:
	if not player:
		return
	
	global_position.y = lerp(global_position.y, player.global_position.y, delta * 10)
	
	var player_distance := global_position.distance_to(player.global_position)
	
	if player_distance < activate_distance and not active:
		print("goat activated")
		active = true
	
	if not active:
		return
	
	if player_distance > min_player_distance:
		approach_player(delta)


func approach_player(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * move_speed)
	
	look_at(player.global_position)


func _on_bleat_timeout() -> void:
	audio_player.play()
	_create_bleat_timer()


func _create_bleat_timer() -> void:
	var time = bleat_times.pick_random()
	get_tree().create_timer(time).timeout.connect(_on_bleat_timeout)


func _on_interactable_hovered():
	GameEvents.interact_cue_updated.emit("Pet")


func _on_interactable_interacted(interacter):
	audio_player.play()
