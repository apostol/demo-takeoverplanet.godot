extends Node


func _ready():
	Events.connect("planet_resource_changed", self, "_on_planet_resource_changed")
	Events.connect("planet_population_changed", self, "_on_planet_population_changed")
	Events.connect("planet_ship_changed", self, "_on_planet_ship_changed")
	Events.connect("planet_is_attacked", self, "_on_planet_is_attacked")
	Events.connect("planet_is_damaged",self, "_on_planet_is_damaged")
	Events.connect("planet_is_bot_launched",self, "_on_planet_is_bot_launched")

func _on_planet_is_attacked(planet: Planet) -> void:
	print_debug("PlanetLogic: _on_planet_is_attacked", planet)
	pass

func _on_planet_is_bot_launched(planet: Planet, target: Vector2, count: int) -> void:
	print_debug("PlanetLogic: _on_planet_is_bot_launched", planet, target, count)
	planet.ship_amount_changed(-1*count)

func _on_planet_is_damaged(planet: Planet, enemy: Bot, count: int) -> void:
	print_debug("PlanetLogic: _on_planet_is_damaged", planet, enemy, count)
	planet.ship_amount_changed(-1*count)
	enemy.die()

func _on_planet_resource_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_resource_changed", amount)
	pass

func _on_planet_population_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_population_changed", amount)
	pass

func _on_planet_ship_changed(planet: Planet, amount: float) -> void:
	#print_debug("PlanetLogic: _on_planet_ship_changed", amount)
	pass
