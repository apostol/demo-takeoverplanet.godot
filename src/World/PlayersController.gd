extends Node

onready var rnd := RandomNumberGenerator.new()

const player = preload("res://src/World/Player/Player.tscn")
const player_screen_left = preload("res://src/World/Player/Screen/PlayerScreenLeft.tscn")
const player_screen_right = preload("res://src/World/Player/Screen/PlayerScreenRight.tscn")
const player_green = preload("res://src/World/Player/Color/Green.tscn")
const player_red = preload("res://src/World/Player/Color/Red.tscn")

onready var canvas = get_node("../CanvasLayer")

var _player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()

func spawn(star_system)->void:
	var _planets:Array = star_system.get_planets()
	var _list = []
	for _i in _planets:
		if _i is Planet:
			if _i.model.planet_owner == null:
				_list.append(_i)
	
	var _planet_idx = rnd.randi_range(0, _list.size()-1)
	var _planet = _list[_planet_idx]
	_spawn_player(_planet, "PlayerLeft", true, player_green.instance(), player_screen_left.instance())
	_list.remove(_planet_idx)
	_planet_idx = rnd.randi_range(0, _list.size()-1)
	_planet = _list[_planet_idx]
	_spawn_player(_planet, "PlayerRight", false, player_red.instance(), player_screen_right.instance())

func _spawn_player(planet, playerName, is_primary, playerColor, screen)->void:
	var _player = player.instance()
	_player.add_child(screen)
	screen.name = "PlayerScreen"
	canvas.add_child(_player)
	_player.name = playerName
	_player_count +=1
	_player.setup(_player_count, is_primary, playerName, playerColor, planet)
