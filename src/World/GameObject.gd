class_name GameObject
extends Area2D

func _ready() -> void:
	set_physics_process(false)

func get_current_position() -> Vector2:
	return Vector2()
	
