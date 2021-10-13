extends Area2D
class_name GameObject

func is_class(name:String)->bool:
   return name == "GameObject"

func _ready() -> void:
	set_physics_process(false)

func get_current_position() -> Vector2:
	return Vector2()
	
