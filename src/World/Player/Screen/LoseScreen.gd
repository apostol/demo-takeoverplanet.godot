extends Control

onready var scene_tree: = get_tree() #для уменьшения нагрузки на процессор

func _ready() ->void:
	Events.connect("on_player_lose", self, "_on_player_lose")

func _on_player_lose() -> void:
	visible = true
	scene_tree.paused = true
	return
