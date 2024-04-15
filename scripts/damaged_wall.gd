extends Node3D


var broken := false

func damage():
	if broken:
		return
	broken = true
	$Wall.visible = false
	$CollisionShape3D.queue_free()
	$Decal.visible = false
	$broken_wall.visible = true
