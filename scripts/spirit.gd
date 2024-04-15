extends CharacterBody3D


@export var min_distance := 10.0
@export var move_speed := 1.0

var dead := false


func _physics_process(delta):
	if dead:
		return
	
	if not Globals.player:
		return
	
	var player_position := Globals.player.global_position
	
	if global_position.distance_to(player_position) < min_distance:
		global_position = lerp(global_position, player_position, delta * move_speed)


func damage():
	dead = true
	$AnimationPlayer.play("die")


func _on_area_3d_body_entered(body):
	if body is Player:
		body.die()
