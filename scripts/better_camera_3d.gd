extends Camera3D
class_name BetterCamera3D


func _ready():
	GameEvents.camera_traumaed.connect(_on_camera_trauma)


func _on_camera_trauma(amount = 0.1, duration = 0.3):
	_camera_shake(amount, duration)


func _camera_shake(amount: float, duration: float):
	var initial_transform = self.transform 
	var elapsed_time = 0.0

	while elapsed_time < duration:
		h_offset = randf_range(-amount, amount)
		v_offset = randf_range(-amount, amount)
		elapsed_time += get_process_delta_time()
		await get_tree().process_frame

	self.transform = initial_transform
