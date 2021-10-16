extends Node

onready var player_label = get_node("Player")
onready var planets_label = get_node("Planets")
onready var bots_label = get_node("Bots")

var bots_template
var player_template
var planets_template

func _ready():
	bots_template = bots_label.text
	player_template = player_label.text
	planets_template = planets_label.text

func update_bot_counts(bots_count)->void:
	bots_label.text = bots_template % bots_count

func update_player_name(name)->void:
	player_label.text = player_template % name

func update_planet_counts(count)->void:
	planets_label.text = planets_template % count

func show_win():
	print_debug("Вы выиграли!!!!")

func show_lose():
	print_debug("Вы проиграли!!!!")
