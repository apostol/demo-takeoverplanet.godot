class_name GameWorld
extends Node

onready var rnd := RandomNumberGenerator.new()
onready var star_system_spawner: StarSystemSpawner = get_node("StarSystemSpawner")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#yield(owner, "ready")
	setup()
	
func setup() -> void:
	rnd.randomize()
	#Events.connect("upgrade_chosen", self, "_on_Events_upgrade_chosen")
	#star_system_spawner.connect("cluster_depleted", self, "_on_AsteroidSpawner_cluster_depleted")
	star_system_spawner.spawn_star_system(rnd, StarSystemSetings.Size)
