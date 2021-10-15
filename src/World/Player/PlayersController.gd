extends Node

onready var rnd := RandomNumberGenerator.new()

const player_human = preload("res://src/World/Player/PlayerHuman.tscn")
const player_bot = preload("res://src/World/Player/PlayerBot.tscn")
#const player_bot = preload("res://src/World/Player/PlayerNetwork.tscn")

onready var player_screen = get_node("../CanvasLayer/PlayerInfo")
onready var enemy_screen = get_node("../CanvasLayer/PlayerEnemyInfo")

var _player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	pass # Replace with function body.

func spawn(star_system)->void:
	var _planets:Array = star_system.get_planets()
	var _list = []
	for _i in _planets:
		if _i is Planet:
			if _i.model.planet_owner == null:
				_list.append(_i)
	
	var _planet_idx = rnd.randi_range(0, _list.size()-1)
	var _planet = _list[_planet_idx]
	_spawn_player(_planet)
	_list.erase(_planet_idx)
	_planet_idx = rnd.randi_range(0, _list.size()-1)
	_planet = _list[_planet_idx]
	_spawn_enemy(_planet)
	pass

func _spawn_player(planet)->void:
	var player = player_human.instance()
	add_child(player)
	_player_count +=1
	player.setup(_player_count)
	player_screen.setup(player)
	planet.model.set_owner(player) #TODO: Player
	pass

func _spawn_enemy(planet)->void:
	var enemy = player_bot.instance()
	add_child(enemy)
	_player_count +=1
	enemy.setup(_player_count)
	planet.model.set_owner(enemy)
	pass




