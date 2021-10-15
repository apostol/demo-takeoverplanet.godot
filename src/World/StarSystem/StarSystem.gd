extends Node2D
class_name StarSystem

# Star System signals
signal star_system_depleted # звездная система истощена - в ней больше нет ресурсов
signal star_system_free # заведная система свободна (нет ни одного игрока)
signal star_system_died # звездная система умерла (перерождение планет)
signal star_system_is_destroying #Звездная система разрушается (звезда умирает)
signal star_system_is_occupied # зведная система захвачена игроком
signal star_system_is_attacked # звездная система атакована

# прототип для планеты
const StarScene := preload("../Star/Star.tscn")
const PlanetScene := preload("../Planet/Planet.tscn")

var count_of_planets: = 0

func _init() -> void:
	set_as_toplevel(true) #TODO: выснить зачем это
	
func setup(location: Vector2) -> void:
	global_position = location
	var star := StarScene.instance()
	star.position = Vector2(0,0)
	add_child(star)

func get_count_of_planets() -> int:
	return count_of_planets

func get_planets() -> Array:
	return get_children()

func spawn_planets(
	rnd: RandomNumberGenerator,
	settings: StarSystemSettings,
	cluster_radius: float
) -> Array:
	count_of_planets = rnd.randi_range(settings.Planet.count.min, settings.Planet.count.max)
	var orbit_radius: float = settings.Planet.orbit.min
	print("Planets count:", count_of_planets)
	print("Orbit min:", settings.Planet.orbit.min)
	for _i in range(count_of_planets):
		orbit_radius += 300
		var offset_position := Vector2(orbit_radius, orbit_radius)
		var planet = _create_planet(_i, rnd, offset_position)
	return get_children()

func _create_planet(
	id: int,
	rnd: RandomNumberGenerator,
	offset: Vector2
) -> Planet:
	var planet = PlanetScene.instance()
	add_child(planet)
	planet.setup(id, rnd, offset)
	return planet
