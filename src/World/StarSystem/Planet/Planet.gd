class_name Planet
extends GameObject

onready var sprite := get_node("Animation")
onready var draw_layer: PlanetDrawLayer = get_node("Animation/DrawLayer")
onready var collision: CollisionShape2D = get_node("CollisionShape2D")

export var min_resource_amount: float = 100
export var min_population_amount := 1
export var min_ship_amount := 100.0
export var min_scale := 0.2
export var planet_name := "Unknown"
export var planet_speed : = 0.1

var max_resource_amount: float
var resource_amount: float

var max_population_amount: float
var population_amount: float

var max_ship_amount: int
var ship_amount: int
var ship_generator_timer: = Timer.new()

var time_left = 0.0
var pressed = false
var angle_is_calculating = true

var planet_id: int = 1
var planet_owner: Player = null

func setup(
		id: int,
		rnd: RandomNumberGenerator, 
		offset: Vector2) -> void:

	planet_id = id
	planet_speed = rnd.randf_range(0.1,1)
	rotation = rnd.randf_range(0, 2 * PI)
	max_resource_amount = rnd.randf_range(min_resource_amount, min_resource_amount * 10)
	max_population_amount = rnd.randf_range(min_population_amount, min_population_amount * 10)
	max_ship_amount = rnd.randf_range(min_ship_amount, min_ship_amount * 10)

	var planet_scale: float = 1+max_ship_amount/min_ship_amount/10
	sprite.setup(rnd, offset, planet_scale)
	collision.translate(offset)
	collision.scale = Vector2(planet_scale, planet_scale)
	
	_add_timer(ship_generator_timer, "_on_ship_generator_timer")
	_on_ship_generator_timer()
	Events.emit_signal("planet_free", self)

func get_planet_id() -> int:
	return planet_id

func get_planet_owner() -> Player:
	return planet_owner

func set_planet_owner(owner: Player) -> void:
	planet_owner = owner
	Events.emit_signal("planet_is_occupied", self, owner)

func _on_ship_generator_timer() -> void:
	ship_amount_changed(min(10, max_ship_amount-ship_amount))
	ship_generator_timer.start(1)

func resource_amount_changed(value: float) -> float:
	var mined := min(resource_amount, value)
	resource_amount += value
	Events.emit_signal("planet_resource_changed", self, resource_amount)
	return mined

func population_amount_changed(value: float) -> float:
	var mined := min(population_amount, value)
	population_amount += value
	Events.emit_signal("planet_population_changed", self, population_amount)
	return mined

func ship_amount_changed(value: int) -> int:
	ship_amount += value
	if ship_amount<0: ship_amount = 0
	Events.emit_signal("planet_ship_changed", self, ship_amount)
	return ship_amount

func get_current_position() -> Vector2:
	return sprite.get_global_transform().get_origin()

func _process(delta):
	#rotation += planet_speed * delta
	if pressed && angle_is_calculating:
		if draw_layer.arc_angle_fill<=get_angle_to_show_ship_count():
			time_left += delta
			draw_layer.arc_angle_fill = 72*time_left
		Events.emit_signal("planet_is_touching", self, time_left)
	draw_layer.arc_angle_ship = get_angle_to_show_ship_count()

func _input(event) -> void:
	if event is InputEventSingleScreenTap:
		if (sprite.touch_rect.has_point(sprite.offset - sprite.get_local_mouse_position())):
			Events.emit_signal("planet_is_selected", get_parent())
			get_tree().set_input_as_handled()
	if event is InputEventSingleScreenTouch:
		if sprite.touch_rect.has_point(sprite.offset - sprite.get_local_mouse_position()):
			pressed = event.pressed
			time_left = 0
			if pressed:
				draw_layer.isEnabled = true
				angle_is_calculating = true
			else:
				draw_layer.arc_angle_fill = 0
				angle_is_calculating = false
				draw_layer.isEnabled = false
		else:
			if not angle_is_calculating &&  draw_layer.isEnabled:
				Events.emit_signal(
					"planet_is_bot_launched", 
					self, 
					sprite.get_global_mouse_position(), 
					get_ship_count_to_send())
				draw_layer.arc_angle_fill = 0
				draw_layer.isEnabled = false
	if event is InputEventSingleScreenDrag:
		angle_is_calculating = false

func get_ship_count_to_send() -> int:
	return int(ship_amount*draw_layer.arc_angle_fill/draw_layer.arc_angle_ship)

func get_angle_to_show_ship_count() -> float:
	return float(360*ship_amount/max_ship_amount)

# Macro to add a timer and connect it's timeout to func_name.
func _add_timer(timer, func_name):
	timer.one_shot = true
	if func_name:
		timer.connect("timeout", self, func_name)
	self.add_child(timer)

func _on_Planet_area_entered(area):
	if area is Bot: #Если мы столкнулись с ботом
		var bot = area as Bot
		if bot.source != self: #если это не наш бот с этой планеты
			var count = bot.get_count()
			Events.emit_signal("planet_is_attacked", self)
			Events.emit_signal("planet_is_damaged", self, bot, count)
