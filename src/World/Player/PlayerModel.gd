extends Node


export var player_id: int = 0 #идентификатор игрока
export var player_name := "Unknown"
export var ships = {} #количество кораблей на каждой планете

var color: ColorRect

signal score_updated
signal ppl_updated
signal ships_updated
signal resources_updated
signal planets_updated
signal player_died

var score: = 0 setget set_score, get_score

var planets: = {
	"founded": 0, #исседовано
	"takeover": 0, #захвачено
	"failed": 0, #проиграно
	"destroyed": 0 #уничтожено
} setget set_planets, get_planets



#var ships: = {
#	"built": 0, #построено
#	"destoroyed": 0, #уничтожено
#	"taked": 0, #захвачено
#} setget set_ships, get_ships

var resources: = {
	"harvested": 0, #собрано
	"spended": 0, #потрачено
	"taked": 0, #захвачено
} setget set_resources, get_resources

var colonizers: = {
	#родилось
	#умерло своей смертью
	#убито
} setget set_ppl, get_ppl



#сброс данных БЕЗ вызова событий, та как находимся в одном классе оработчике.
func reset() -> void:
	score = 0
	#TODO: надо очищать и прочие данные
	return

func set_ships(values: Dictionary) -> void:
	emit_signal("ships_updated", {})
	return
	
func get_ships() -> Dictionary:
	return {}

func set_resources(values: Dictionary) -> void:
	emit_signal("resources_updated", {})
	return
	
func get_resources() -> Dictionary:
	return {}

func set_planets(value: Dictionary) -> void:
	emit_signal("planets_updated", {})
	return

func get_planets() -> Dictionary:
	return {}

func set_ppl(values: Dictionary) -> void:
	emit_signal("ppl_updated", {})
	return
	
func get_ppl() -> Dictionary:
	return {}

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated", score)

func get_score() -> int:
	return score

