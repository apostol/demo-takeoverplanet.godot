extends Node

onready var view = get_node("PlayerScreen")
onready var model = get_node("PlayerModel")

func _ready():
	Events.connect("planet_ship_changed", self, "_on_planet_ship_changed")
	Events.connect("planet_is_occupied", self, "_on_planet_is_occupied")
	Events.connect("planet_free", self, "_on_planet_free")

func setup(id, player_name, player_color, planet) -> void:
	model.player_id = id
	model.player_name = player_name
	model.color = player_color
	view.update_player_name(player_name)
	planet.model.set_owner(self)

func _on_planet_free(planet) -> void:
	planet.emit_signal("planet_change_type", null)

func _on_planet_is_occupied(planet, owner) -> void:
		planet.emit_signal("planet_change_type", owner.model.color)

func _on_planet_ship_changed(planet, amount) -> void:
	if planet.model.get_owner() == self:
		print_debug(planet, self, view)
		model.ships[planet.model.get_planet_id()] = amount
		var ships_count = 0
		for _i in model.ships:
			ships_count += model.ships[_i]
		view.update_bot_counts(ships_count)
