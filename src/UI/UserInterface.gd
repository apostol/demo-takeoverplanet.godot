extends Control

onready var scene_tree: = get_tree() #для уменьшения нагрузки на процессор
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var pause_title: Label = get_node("PauseOverlay/Paused")

var paused: = false setget set_paused

func _ready() ->void:
	#PlayerData.connect("score_updated", self, "update_interfce")
	#PlayerData.connect("player_died", self, "_on_player_died")
	update_interface()

func update_interface() -> void:
	#score.text = "Score: %s" % PlayerData.score
	return

func _on_player_died() -> void:
	self.paused = true
	self.died = true
	pause_title.text = "You died"
	return

func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("pause")):
		self.paused = not paused #в тком варианте вызывается событие
		scene_tree.set_input_as_handled()
	return

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	return
