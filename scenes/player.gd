extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var paused := false
@export var camera_turn_speed = 2.0
@export var mouse_sensitivity = 0.002
@export var camera: Camera3D
@export var raycast: RayCast3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_key_input(event):
	if Input.is_action_just_pressed("interact"):
		var collider := raycast.get_collider()
		if collider and collider is Interactable:
			collider.interact()


func _unhandled_input(event):
	event =  event as InputEventMouseMotion
	if event and not paused:
		var direction = -event.relative * mouse_sensitivity
		rotation.y = lerp(rotation.y, rotation.y + direction.x, camera_turn_speed)
		camera.rotation.x = lerp(camera.rotation.x, camera.rotation.x + direction.y, camera_turn_speed)
		camera.rotation_degrees.x  =clampf(camera.rotation_degrees.x, -89, 89)


func _physics_process(delta):
	if paused:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	_update_ray()


func _update_ray() -> void:
	var collider := raycast.get_collider()
	if collider and collider is Interactable:
		collider.hover()
	else:
		GameEvents.interact_cue_cleared.emit()
