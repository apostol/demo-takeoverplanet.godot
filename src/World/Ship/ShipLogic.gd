class_name ShipLogic
extends Node

onready var ship_prototype = preload("Ship.tscn")

func _ready():
	Events.connect("planet_is_ship_launched", self, "_on_planet_is_ship_launched")

func _on_planet_is_ship_launched(source, target, count) -> void:
	var ship = ship_prototype.instance()
	add_child(ship, true)
	ship.setup(source, target, count)
