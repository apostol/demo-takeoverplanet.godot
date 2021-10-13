extends Node

const player_human = preload("res://src/World/Player/PlayerHuman.tscn")
const player_bot = preload("res://src/World/Player/PlayerBot.tscn")

var _player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn(rnd, star_system)->void:
	var _planets:Array = star_system.get_planets()
	var _list = {}
	for _i in _planets:
		if _i.is_class("Planet"):
			if _i.get_planet_owner() == null:
				_list[_i.get_planet_id()] = _i
	
	var _planet_idx = rnd.randi_range(0, _list.size()-1)
	var _planet = _planets[_planet_idx]
	_spawn_player(_planet)
	_list.erase(_planet_idx)
	_planet_idx = rnd.randi_range(0, _list.size()-1)
	_planet = _planets[_planet_idx]
	_spawn_enemy(_planet)
	pass

func _spawn_player(planet)->void:
	var player = player_human.instance()
	add_child(player)
	_player_count +=1
	player.setup(_player_count)
	planet.set_planet_owner(player) #TODO: Player
	pass

func _spawn_enemy(planet)->void:
	var enemy = player_bot.instance()
	add_child(enemy)
	_player_count +=1
	enemy.setup(_player_count)
	planet.set_planet_owner(enemy) #TODO: Player
	pass




