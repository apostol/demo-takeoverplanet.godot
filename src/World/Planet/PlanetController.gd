extends Node

class_name Planet
func is_class(name:String)->bool:
   return name == "Planet"

signal planet_is_attacked(bot)
signal planet_change_type(type)

onready var model = get_node("PlanetModel")
onready var view = get_node("PlanetView")
onready var screen = get_node("PlanetScreen")

var ship_generator_timer = Timer.new()

func setup(
		id: int,
		rnd: RandomNumberGenerator, 
		orbit: Vector2) -> void:

	model.setup(
		rnd,
		id, #ID
		"Unknown",
		rnd.randf_range(0.1,1), #Speed
		rnd.randf_range(0, 2 * PI), #angle
		orbit #orbit
	)
	connect("planet_is_attacked", self, "_on_planet_is_attacked")
	connect("planet_change_type", self, "_on_planet_change_type")
	
	view.setup(rnd, model)
	view.connect("planet_is_touching", self, "_on_planet_is_touching")
	view.connect("planet_is_selected", self, "_on_planet_is_selected")
	view.connect("planet_bot_launched", self, "_on_planet_bot_launched")
	model.connect("planet_ship_changed", self, "_on_planet_ship_changed")
	
	_add_timer(ship_generator_timer, "_on_ship_generator_timer")
	_on_ship_generator_timer()
	Events.emit_signal("planet_free", self)

func _on_planet_ship_changed(value) -> void:
	Events.emit_signal("planet_ship_changed", self, value)

func _on_planet_change_type(type) -> void:
	var _name = "PlanetType"
	var _node = view.sprite.find_node(_name, false, false)
	if (_node):
		view.sprite.remove_child(_node)
	if type:
		type.name = _name
		view.sprite.add_child(type.duplicate())
		type.visible = true

func _on_ship_generator_timer() -> void:
	if (model.get_owner()):
		var _count = model.planet_max_ship_amount-model.planet_ship_amount
		if _count>0:
			ship_amount_changed(min(10, _count)) 
	ship_generator_timer.start(1)

func ship_amount_changed(value: int) -> int:
	#все вычисления производим в контроллере, модель только меняет данные и высылает события
	var _current = model.planet_ship_amount
	if _current + value < 0: 
		_current = 0 
	else: 
		_current = _current + value
	#
	model.planet_ship_amount = _current #тут срабатывает событие об изменении в модели
	return _current

func _on_planet_is_touching(planet, left_time) -> void:
	pass

func _on_planet_is_selected(planet) -> void:
	#тут проблема в том, чт одля каждой планеты мы делаем скрин,
	#а по идее нам надо всего-лишь 1 скрин, который настраивается под планету
	screen.planet = planet
	pass

func _on_planet_bot_launched(planet, target_position, bot_count) -> void:
	ship_amount_changed(-1*bot_count)
	Events.emit_signal("planet_is_bot_launched", planet, target_position, bot_count)

func get_current_position() -> Vector2:
	return view.get_current_position()

# Macro to add a timer and connect it's timeout to func_name.
func _add_timer(timer, func_name):
	timer.one_shot = true
	if func_name:
		timer.connect("timeout", self, func_name)
	self.add_child(timer)

func _on_planet_is_attacked(bot):
	if bot.source != self: #если это не наш бот с этой планеты
		var count = bot.get_count()
		if bot.get_owner() == model.get_owner():
			#Это мои боты
			model.planet_ship_amount = count + model.planet_ship_amount
		else:
			if count > model.planet_ship_amount:
				model.planet_ship_amount = count - model.planet_ship_amount
				model.set_owner(bot.get_owner())
			elif count < model.planet_ship_amount:
				model.planet_ship_amount = model.planet_ship_amount - count
			else:
				model.planet_ship_amount = 0
				model.set_owner(null)
		bot.die() #умерли прилетевшие боты
