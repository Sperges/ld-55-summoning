extends Node3D


func damage():
	$Wall.queue_free()
	$Decal.visible = false
	$broken_wall.visible = true
