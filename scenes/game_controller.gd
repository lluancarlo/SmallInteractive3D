extends Node
class_name GameController

@export_category("Nodes")
@export var lever : Lever
@export var lever_text : Label
@export var door : Door


func _ready() -> void:
	assert(lever != null, "lever node should be defined")
	assert(lever_text != null, "lever_text node should be defined")
	assert(door != null, "door node should be defined")


func _on_pressure_plate_pressed() -> void:
	lever.set_lock_status(false)
	lever_text.visible = true


func _on_pressure_plate_unpressed() -> void:
	lever.set_lock_status(true)
	lever_text.visible = false


func _on_lever_activated() -> void:
	door.open_door()
