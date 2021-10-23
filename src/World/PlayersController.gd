extends Node

onready var rnd := RandomNumberGenerator.new()

const player = preload("res://src/World/Player/Player.tscn")
const actor_ai = preload("res://src/World/Player/Actor/AIActor.tscn")
const actor_human = preload("res://src/World/Player/Actor/HumanActor.tscn")
const actor_online = preload("res://src/World/Player/Actor/NetworkActor.tscn")
const player_screen_left = preload("res://src/World/Player/Screen/PlayerScreenLeft.tscn")
const player_screen_right = preload("res://src/World/Player/Screen/PlayerScreenRight.tscn")
const player_green = preload("res://src/World/Player/Color/Green.tscn")
const player_red = preload("res://src/World/Player/Color/Red.tscn")


onready var canvas = get_node("../CanvasLayer")

var _player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()

func spawn(star_system, left_type, right_type)->void:
	var _planets:Array = star_system.get_planets()
	var _list = []
	for _i in _planets:
		if _i is Planet:
			if _i.model.planet_owner == null:
				_list.append(_i)
	
	var _planet_idx = rnd.randi_range(0, _list.size()-1)
	var _planet = _list[_planet_idx]
	var _player = find_player(left_type)
	_spawn_player(_player, _planet, true, player_green.instance(), player_screen_left.instance())
	_list.remove(_planet_idx)
	_planet_idx = rnd.randi_range(0, _list.size()-1)
	_planet = _list[_planet_idx]
	_player = find_player(right_type)
	_spawn_player(_player, _planet, false, player_red.instance(), player_screen_right.instance())

func _spawn_player(player, planet, is_primary, playerColor, screen)->void:
	player.add_child(screen)
	screen.name = "PlayerScreen"
	canvas.add_child(player)
	player.setup(is_primary, playerColor, planet)

func find_player(type):
	var _player = player.instance()
	if type == Global.PLAYER_TYPES.AI:
		_player.add_child(actor_ai.instance())
	elif type == Global.PLAYER_TYPES.ONLINE:
		_player.add_child(actor_online.instance())
	else:
		_player.add_child(actor_human.instance())
	return _player
