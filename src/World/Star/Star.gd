extends GameObject
#class_name Star

onready var sprite := get_node("Animation")
onready var collision := get_node("CollisionShape2D")
var _rect: Rect2

func _ready() -> void:
	set_physics_process(false)
	var _frame = sprite.frames.get_frame("default",0)
	var _size = _frame.get_size()
	_rect = Rect2(Vector2.ZERO-_size/2, _size)
	scale = Vector2(10,10)

func get_current_position() -> Vector2:
	return get_global_transform().get_origin()

func _input(event) -> void:
	if event is InputEventSingleScreenTap:
		if (_rect.has_point(get_local_mouse_position())):
			Events.emit_signal("star_is_selected", self)

func _on_Star_area_entered(area):
	if area is Ship:
		var ship = area as Ship
		ship.die()
