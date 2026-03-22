extends CharacterBody3D
class_name Player


const GROUP_MOVABLE = &"movable"
const INPUT_FORWARD = &"forward"
const INPUT_BACKWARD = &"backward"
const INPUT_RIGHT = &"right"
const INPUT_LEFT = &"left"

@onready var _camera : Camera3D = $Camera3D

@export var move_speed : float = 5.0
@export var rotation_speed : float = 2.0
@export var acceleration = 10.0
@export var push_force = 1.0


func _physics_process(delta: float) -> void:
	simulate_gravity(delta)
	apply_inputs(delta)
	move_and_slide()
	simulate_collision()


func simulate_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func apply_inputs(delta: float) -> void:
	# move
	var move = 0
	if Input.is_action_pressed(INPUT_FORWARD):
		move += 1
	if Input.is_action_pressed(INPUT_BACKWARD):
		move -= 1
		
	if move != 0.0:
		velocity = -transform.basis.z * move * move_speed
	else:
		velocity = velocity.move_toward(Vector3.ZERO, move_speed * 10.0 * delta)
	
	# Rotation
	var rot = Input.get_axis(INPUT_RIGHT, INPUT_LEFT)
	if rot != 0.0:
		rotate_y(rot * rotation_speed * delta)


func simulate_collision() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D and collider.is_in_group(GROUP_MOVABLE):
			collider.apply_central_impulse(-collision.get_normal() * push_force)
