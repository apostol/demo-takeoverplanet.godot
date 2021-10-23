tool
extends Button

export(String, FILE) var next_scene_path:= ""
export(Global.PLAYER_TYPES) var player_left = Global.PLAYER_TYPES.AI
export(Global.PLAYER_TYPES) var player_right = Global.PLAYER_TYPES.AI

func _on_button_up():
	Global.PLAYER_LEFT = player_left
	Global.PLAYER_RIGHT = player_right
	get_tree().paused = false
	var error = get_tree().change_scene(next_scene_path)
	print_debug(error)
	
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
