extends Node
class_name GameWorld

var _world_objects := []

onready var rnd := RandomNumberGenerator.new()
onready var star_system_spawner = get_node("StarSystemSpawner")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#yield(owner, "ready")
	setup()
	
func setup() -> void:
	rnd.randomize()
	Events.connect("star_system_is_spawned", self, "_on_star_system_is_spawned")
	star_system_spawner.spawn_star_system(rnd, StarSystemSetings.Size)

func _on_star_system_is_spawned(star_system) -> void:
	_world_objects.append(weakref(star_system))
	Events.emit_signal("node_spawned", star_system)
