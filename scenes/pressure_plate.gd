extends Node3D
class_name PressurePlate


const GROUP_MOVABLE = &"movable"

@onready var mesh : MeshInstance3D = $MeshInstance3D
@onready var _mat_on : Material = preload("res://materials/pressure_plate_on.material")
@onready var _mat_off : Material = preload("res://materials/pressure_plate_off.material")

signal pressed()
signal unpressed()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group(GROUP_MOVABLE):
		set_status(true)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group(GROUP_MOVABLE):
		set_status(false)


func set_status(status: bool) -> void:
	if status:
		mesh.mesh.surface_set_material(0, _mat_on)
		pressed.emit()
	else:
		mesh.mesh.surface_set_material(0, _mat_off)
		unpressed.emit()
