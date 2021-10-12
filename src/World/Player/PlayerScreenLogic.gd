class_name PlayerScreenLogic
extends Node

onready var player_label = get_node("VBoxContainer/Player")
onready var planets_label = get_node("VBoxContainer/Planets")
onready var bots_label = get_node("VBoxContainer/Bots")


var bots = {}
var bots_count: int = 0
var planets_count: int = 0
var player_name: String = "Player"

func _ready():
	Events.connect("planet_resource_changed", self, "_on_planet_resource_changed")
	Events.connect("planet_population_changed", self, "_on_planet_population_changed")
	Events.connect("planet_ship_changed", self, "_on_planet_ship_changed")

func _on_planet_resource_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_resource_changed", amount)
	pass

func _on_planet_population_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_population_changed", amount)
	pass

func _on_planet_ship_changed(planet: Planet, amount: float) -> void:
	bots[planet.get_planet_id()] = amount
	bots_count = 0
	for _i in bots:
		bots_count += bots[_i]
	bots_label.text = "Bots: %s" % bots_count
