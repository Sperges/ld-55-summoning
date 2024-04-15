extends Node3D

@export var speed := 6
@export var direction := Vector3.ZERO

func _physics_process(delta):
	position += direction * speed * delta

func _ready():
	$AudioStreamPlayer3D.play()
	get_tree().create_timer(1).timeout.connect(func():
		queue_free()
	)
	


func _on_area_3d_body_entered(body):
	print(body)
	if body.has_method("damage"):
		print("break")
		queue_free()
		body.damage()
