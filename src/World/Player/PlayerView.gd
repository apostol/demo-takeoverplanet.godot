extends Node

onready var player_label = get_node("Player")
onready var planets_label = get_node("Planets")
onready var ships_label = get_node("Ships")

var ships_template
var player_template
var planets_template

func _ready():
	ships_template = ships_label.text
	player_template = player_label.text
	planets_template = planets_label.text

func update_ships_counts(bots_count)->void:
	ships_label.text = ships_template % bots_count

func update_player_name(name)->void:
	player_label.text = player_template % name

func update_planet_counts(count)->void:
	planets_label.text = planets_template % count

func show_win():
	print_debug("Вы выиграли!!!!")

func show_lose():
	print_debug("Вы проиграли!!!!")
