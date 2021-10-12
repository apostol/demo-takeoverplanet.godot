class_name BotLogic
extends Node

onready var bot_prototype = preload("Bot.tscn")

func _ready():
	Events.connect("planet_is_bot_launched", self, "_on_planet_is_bot_launched")

func _on_planet_is_bot_launched(source, target, count) -> void:
	var bot = bot_prototype.instance()
	add_child(bot, true)
	bot.setup(source, target, count)
