extends CharacterBody3D
class_name Goat

@export var player: Player
@export var min_player_distance: float = 2
@export var move_speed: float = 2.0
@export var turn_speed: float = 2.0

func _physics_process(delta: float) -> void:
	if not player:
		return
	if global_position.distance_to(player.global_position) > min_player_distance:
		approach_player(delta)


func approach_player(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * move_speed)
	look_at(player.global_position)
