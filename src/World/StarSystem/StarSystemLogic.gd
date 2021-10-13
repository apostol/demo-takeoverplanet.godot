extends Node

onready var planets_label = get_node("VBoxContainer/Planets")
onready var timer_label = get_node("VBoxContainer/Timer")

onready var players_controller = get_node("Players")

var planets = {}
var planets_count = 0
var timer: float = 0

var _planets:Array

func _init():
	Events.connect("star_system_is_spawned", self, "_on_star_system_is_spawned")
	Events.connect("planet_free", self, "_on_planet_free")
	Events.connect("planet_is_occupied", self, "_on_planet_is_occupied")

func _ready():
	pass
		
func _on_planet_is_occupied(planet, owner) -> void:
	planets[planet.get_planet_id()] = false
	planets_info_update()

func _on_planet_free(planet, owner) -> void:
	planets[planet.get_planet_id()] = true
	planets_info_update()

func _on_star_system_is_spawned(star_system) -> void:
	#players_controller.spawn(rnd, star_system)
	planets_info_update()

func _process(delta):
	timer += delta
	timer_label.text = "Timer: %s sec" % timer

func planets_info_update() -> void:
	var free_count = planets_count
	for _i in planets:
		if !planets[_i]:
			free_count -=1
	planets_label.text = "Planets: %s/%s" % [planets_count, free_count]
	
