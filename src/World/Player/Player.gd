class_name Player
extends Node

var player_id: int = 0
var player_name: String = "Unknown"

func setup(id: int) -> void:
	player_id = id

func get_player_id() -> int:
	return player_id

func get_player_name() -> String:
	return player_name

