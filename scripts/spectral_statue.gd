extends Node3D


func _on_area_3d_body_entered(body):
	if body is Hand:
		body.die()
