extends Node
#class_name PlayerScreenLogic

onready var player_label = get_node("VBoxContainer/Player")
onready var planets_label = get_node("VBoxContainer/Planets")
onready var bots_label = get_node("VBoxContainer/Bots")

onready var my_planet = get_node("PlanetTypes/My")
onready var free_planet = get_node("PlanetTypes/Free")
onready var enemy_planet = get_node("PlanetTypes/Enemy")

var bots = {}
var bots_count: int = 0
var planets_count: int = 0
var player_name: String = "Player"
var iam

func _ready():
	Events.connect("planet_resource_changed", self, "_on_planet_resource_changed")
	Events.connect("planet_population_changed", self, "_on_planet_population_changed")
	Events.connect("planet_ship_changed", self, "_on_planet_ship_changed")
	Events.connect("planet_is_occupied", self, "_on_planet_is_occupied")
	Events.connect("planet_free", self, "_on_planet_free")

func setup(player) -> void:
	iam = player

func _on_planet_free(planet) -> void:
	planet.emit_signal("planet_change_type", free_planet.duplicate())

func _on_planet_is_occupied(planet, owner) -> void:
	if iam != owner:
		planet.emit_signal("planet_change_type", enemy_planet.duplicate())
	else:
		planet.emit_signal("planet_change_type", my_planet.duplicate())

func _on_planet_resource_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_resource_changed", amount)
	

func _on_planet_population_changed(planet: Planet, amount: float) -> void:
	print_debug("PlanetLogic: _on_planet_population_changed", amount)
	

func _on_planet_ship_changed(planet: Planet, amount: float) -> void:
	bots[planet.get_planet_id()] = amount
	bots_count = 0
	for _i in bots:
		bots_count += bots[_i]
	bots_label.text = "Bots: %s" % bots_count
