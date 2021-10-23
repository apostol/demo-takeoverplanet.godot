extends Node
class_name GameWorld

onready var rnd := RandomNumberGenerator.new()
onready var star_system_spawner = get_node("StarSystemSpawner")
onready var players = get_node("Players")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#yield(owner, "ready")
	setup()
	
func setup() -> void:
	rnd.randomize()
	Events.connect("star_system_is_spawned", self, "_on_star_system_is_spawned")
	star_system_spawner.spawn_star_system(rnd, StarSystemSetings.Size)

func _on_star_system_is_spawned(star_system) -> void:
	players.spawn(star_system, Global.PLAYER_LEFT, Global.PLAYER_RIGHT)
