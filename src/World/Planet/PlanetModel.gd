extends Node

signal planet_scale_changed(value)
signal planet_ship_changed(value)


export var planet_min_resource_amount: float = 100
export var planet_min_population_amount := 1
export var planet_min_ship_amount := 100.0
export var planet_min_scale := 0.2

export var planet_max_resource_amount: float
export var planet_resource_amount: float

export var planet_max_population_amount: float
export var planet_population_amount: float

export var planet_max_ship_amount: int
export var planet_ship_amount: int setget set_planet_ship_amount

export var planet_id: int = -1

export var planet_name := "Unknown"
export var planet_speed : = 0.1
export var planet_rotate : = 0.0
export var planet_scale := 0.0 setget set_planet_scale
export var planet_orbit := Vector2(0,0)

var planet_owner

func setup(
		rnd,
		id, #ID
		name, #name
		speed, #Speed
		rotate, #start angle
		orbit #planet orbit
) -> void:
	planet_id = id
	planet_name = name
	planet_speed = speed
	planet_rotate = rotate
	planet_orbit = orbit
	planet_max_resource_amount = rnd.randf_range(planet_min_resource_amount, planet_min_resource_amount * 10) #planet_max_resource
	planet_max_population_amount = rnd.randf_range(planet_min_population_amount, planet_min_population_amount * 10) #Planet max population
	planet_max_ship_amount = rnd.randf_range(planet_min_ship_amount, planet_min_ship_amount * 10) #planet max ship
	planet_scale = 1 + planet_max_ship_amount/planet_min_ship_amount/10
	Events.emit_signal("planet_free", get_parent())

func get_planet_id() -> int:
	return planet_id

func set_owner(owner) -> void:
	planet_owner = owner
	if owner == null:
		Events.emit_signal("planet_free", get_parent())
	else:
		Events.emit_signal("planet_is_occupied", get_parent(), owner)

func get_owner():
	return planet_owner

func set_planet_scale(value) -> void:
	planet_scale = value
	emit_signal("planet_scale_changed", planet_scale)

func set_planet_ship_amount(value) -> void:
	if value > planet_max_ship_amount:
		planet_ship_amount = planet_max_ship_amount
	elif planet_ship_amount < 0 :
		planet_ship_amount = 0
	else:
		planet_ship_amount = value
	emit_signal("planet_ship_changed", planet_ship_amount)
