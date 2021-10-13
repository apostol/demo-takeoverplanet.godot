extends Control
class_name PlanetScreen

onready var scene_tree: = get_tree() #для уменьшения нагрузки на процессор
onready var planet_name: Label = get_node("PlanetName")

var planet = null

func _ready() ->void:
	Events.connect("planet_is_selected", self, "_on_planet_selected")
	Events.connect("object_is_tracking", self, "_on_object_is_tracking")

func _on_object_is_tracking(object) -> void:
	if !object:
		planet = null

func _on_planet_selected(planet) -> void:
	self.planet = planet
	update_interface()

func update_interface() -> void:
	planet_name.text = "%s" % planet.planet_name
	return

func _unhandled_input(event: InputEvent) -> void:
	return

func _process(delta):
	visible = true if planet else false
	if visible :
		update_interface()

