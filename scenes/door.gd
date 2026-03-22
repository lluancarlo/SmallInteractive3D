extends Node3D
class_name Door


@onready var body : Node3D = $StaticBody3D

@export_category("Animation Parameters")
@export var open_limit : float = -4.0
@export var open_duration : float = 1.0


func open_door() -> void:
	create_tween().set_trans(Tween.TRANS_CUBIC)\
		.tween_property(body, "position:x", open_limit, open_duration)
