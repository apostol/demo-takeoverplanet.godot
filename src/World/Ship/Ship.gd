extends GameObject
class_name Ship

signal ship_is_died(ship) #вызываем, когда кораблю умирает
signal ship_attack(planet) #вызываем когда атакуем планету
signal ship_is_launched(ship) #вызываем когда кораблю запущен

onready var count_label = get_node("Count")

var speed := 200
var target: Vector2
var source
var ship_owner
var count: int = 0
var direction: Vector2

func setup(source, target, count) -> void:
	self.source = source
	self.ship_owner = source.model.get_owner() #TODO: ссылка ли копия?
	self.target = target
	self.count = count
	position = source.get_current_position()
	direction = position.direction_to(target)
	rotate(Vector2.UP.angle_to(to_local(target)))
	count_label.text = str(count)

func get_count() -> int:
	return count

func get_owner():
	return ship_owner

func die() -> void:
	print_debug("Ship is died!")
	emit_signal("ship_is_died", self) #TODO: а мне точно вернется объект если его уже освободили? 
	call_deferred("free")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		position += direction * speed * delta

func _on_Bot_area_entered(area):
	var _planet = area.get_parent()
	if _planet is Planet:
		if source != _planet:
			emit_signal("ship_attack", _planet)
			_planet.emit_signal("planet_is_attacked", self)


