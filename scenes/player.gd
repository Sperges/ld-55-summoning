extends CharacterBody3D
class_name Player

const hand_scene := preload("res://scenes/hand.tscn")
const JUMP_VELOCITY = 4.5

@export var paused := false
@export var summon_cooldown := 200
@export var speed := 2.5
@export var camera_turn_speed = 2.0
@export var mouse_sensitivity = 0.002
@export var camera: Camera3D
@export var raycast: RayCast3D
@export var audio_player: AudioStreamPlayer
@export var collision_shape: CollisionShape3D
@export var collision_ray: CollisionShape3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var hand = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_key_input(event):
	if Input.is_action_just_pressed("interact"):
		var collider := raycast.get_collider()
		if collider and collider is Interactable:
			collider.interact()
	if Input.is_action_just_pressed("summon_hand") and not hand:
		hand = hand_scene.instantiate()
		paused = true
		hand.player = self
		hand.camera.current = true
		collision_shape.disabled = true
		collision_ray.disabled = true
		owner.add_child(hand)
		hand.global_position = global_position
		hand.global_rotation = global_rotation


func _unhandled_input(event):
	event =  event as InputEventMouseMotion
	if event and not paused:
		var direction = -event.relative * mouse_sensitivity
		rotation.y = lerp(rotation.y, rotation.y + direction.x, camera_turn_speed)
		camera.rotation.x = lerp(camera.rotation.x, camera.rotation.x + direction.y, camera_turn_speed)
		camera.rotation_degrees.x  =clampf(camera.rotation_degrees.x, -89, 89)


func unpause() -> void:
	collision_shape.disabled = false
	collision_ray.disabled = false
	paused = false


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
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
	_handle_audio()
	_update_ray()


func _handle_audio() -> void:
	if velocity.length() > 0:
		if not audio_player.playing:
			audio_player.play()
	else:
		audio_player.stop()


func _update_ray() -> void:
	var collider := raycast.get_collider()
	if collider and collider is Interactable:
		collider.hover()
	else:
		GameEvents.interact_cue_cleared.emit()
