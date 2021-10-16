extends Control

onready var scene_tree: = get_tree() #для уменьшения нагрузки на процессор

func _ready() ->void:
	Events.connect("on_player_win", self, "_on_player_win")

func _on_player_win() -> void:
	visible = true
	scene_tree.paused = true
	return
