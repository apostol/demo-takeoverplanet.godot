extends Node
class_name Player

signal planet_owner_is_changed(planet, new_owner)

onready var view = get_node("PlayerScreen")
const model_preload = preload("res://src/World/Player/PlayerModel.tscn")

var model

func _ready():
	Events.connect("planet_ship_changed", self, "_on_planet_ship_changed")
	Events.connect("planet_is_occupied", self, "_on_planet_is_occupied")
	Events.connect("planet_free", self, "_on_planet_free")
	connect("planet_owner_is_changed", self, "_on_player_owner_is_changed")

func _on_player_owner_is_changed(planet, new_owner) -> void:
	model.ships.erase(planet.model.planet_id)
	if model.ships.size() == 0:
		if model.is_primary:
			#Вы проиграли
			Events.emit_signal("on_player_lose")
		else:
			#Вы выиграли
			Events.emit_signal("on_player_win")

func setup(id, is_primary, player_name, player_color, planet) -> void:
	model = model_preload.instance()
	add_child(model)
	model.player_id = id
	model.player_name = player_name
	model.color = player_color
	model.ships = {}
	model.is_primary = is_primary
	view.update_player_name(player_name)
	planet.model.set_owner(self)

func _on_planet_free(planet) -> void:
	if planet.model.get_owner() == self:
		planet.emit_signal("planet_change_type", null)

func _on_planet_is_occupied(planet, owner) -> void:
	if planet.model.get_owner() == self:
		planet.emit_signal("planet_change_type", owner.model.color)

func _on_planet_ship_changed(planet, amount) -> void:
	if planet.model.get_owner() == self:
		model.ships[planet.model.get_planet_id()] = amount
		var ships_count = 0
		for _i in model.ships:
			ships_count += model.ships[_i]
		view.update_bot_counts(ships_count)
		view.update_planet_counts(model.ships.size())
