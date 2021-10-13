extends GameObject
class_name Bot

onready var count_label = get_node("Count")

var speed := 200
var target: Vector2
var source
var count: int = 0
var direction: Vector2

func setup(source, target, count) -> void:
	self.source = source
	self.target = target
	self.count = count
	position = source.get_current_position()
	direction = position.direction_to(target)
	rotate(Vector2.UP.angle_to(to_local(target)))
	count_label.text = str(count)

func get_count() -> int:
	return count

func die() -> void:
	print_debug("Bot is died!")
	call_deferred("free")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		position += direction * speed * delta

func _on_Bot_area_entered(area):
	var _planet = area.get_parent()
	if _planet is Planet:
		if source != _planet:
			_planet.emit_signal("planet_is_attacked", self)
			Events.emit_signal("planet_is_attacked", area, self)


