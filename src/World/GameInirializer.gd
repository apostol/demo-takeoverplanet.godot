extends Node

var _world_objects := []

func _ready() -> void:
	Events.connect("star_system_is_spawned", self, "_on_star_system_is_spawned")

func _on_star_system_is_spawned(star_system: StarSystem) -> void:
	_world_objects.append(weakref(star_system))
	Events.emit_signal("node_spawned", star_system)


