extends Node3D
class_name Lever


const INPUT_INTERACT = &"interact"

@onready var pivot : Node3D = $Pivot
@onready var area3D : Area3D = $Area3D

@export_category("Angles")
@export var lock_angle = -90
@export var unlock_angle = -45
@export var active_angle = 45

var can_receive_interaction : bool
var is_player_inside : bool

signal activated()


func set_lock_status(lock: bool) -> void:
	var new_rad = deg_to_rad(lock_angle if lock else unlock_angle)
	create_tween().set_trans(Tween.TRANS_BOUNCE)\
		.tween_property(pivot, "rotation:x", new_rad, 0.5)
	
	can_receive_interaction = !lock
	area3D.monitoring = can_receive_interaction
	set_deferred("monitorable", can_receive_interaction)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player and can_receive_interaction:
		is_player_inside = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player and can_receive_interaction:
		is_player_inside = false


func _unhandled_input(event) -> void:
	if is_player_inside and event.is_action_pressed(INPUT_INTERACT):
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
		tween.finished.connect(func(): activated.emit())
		tween.tween_property(pivot, "rotation:x", deg_to_rad(active_angle), 0.5)
		get_viewport().set_input_as_handled()
