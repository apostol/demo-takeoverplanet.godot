extends Node

onready var player_label = get_node("Player")
onready var planets_label = get_node("Planets")
onready var bots_label = get_node("Bots")

func _ready():
	pass

func update_bot_counts(bots_count)->void:
	bots_label.text = "Bots: %s" % bots_count

func update_player_name(name)->void:
	player_label.text = "Player: %s" % name
