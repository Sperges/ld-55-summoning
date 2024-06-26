extends CharacterBody3D
class_name Hand


@export var SPEED = 5.0
@export var camera_turn_speed = 2.0
@export var mouse_sensitivity = 0.002
@export var camera: Camera3D
@export var camera_anchor: Node3D
@export var player: Player
@export var raycast: RayCast3D
@export var has_liquid: bool = false: set = _set_has_liquid
@export var hand_mesh: MeshInstance3D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var dead := false

func _set_has_liquid(value: bool):
	if dead:
		return
	has_liquid = value
	if has_liquid:
		$Liquid.show()
		hand_mesh.rotation_degrees.z = 180
	else:
		$Liquid.hide()
		hand_mesh.rotation_degrees.z = 0


func die():
	if dead:
		return
	if Globals.first_hand_death:
		Globals.first_hand_death = false
		GameEvents.inner_voice_updated.emit("Best to avoid summoning near those statues...")
	dead = true
	print("die")
	$AnimationPlayer.play("die")
	await $AnimationPlayer.animation_finished
	_despawn()


func _despawn():
	player.camera.current = true
	player.unpause.call_deferred()
	queue_free()


func _unhandled_key_input(event):
	if dead:
		return
	if Input.is_action_just_pressed("summon_hand"):
		_despawn()
	if Input.is_action_just_pressed("interact"):
		var collider := raycast.get_collider()
		if collider and collider is Interactable:
			collider.interact(self)


func _unhandled_input(event):
	if dead:
		return
	event =  event as InputEventMouseMotion
	if event:
		var direction = -event.relative * mouse_sensitivity
		rotation.y = lerp(rotation.y, rotation.y + direction.x, camera_turn_speed)
		camera_anchor.rotation.x = lerp(camera_anchor.rotation.x, camera_anchor.rotation.x + direction.y, camera_turn_speed)
		camera_anchor.rotation_degrees.x  =clampf(camera_anchor.rotation_degrees.x, -60, 60)


func _physics_process(delta):
	if dead:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

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
