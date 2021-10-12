class_name StarSystemSpawner
extends Node2D

func spawn_star_system(rnd: RandomNumberGenerator, cluster_radius: float) -> void:
	_spawn_star_system_cluster(rnd, cluster_radius)
	return

func _spawn_star_system_cluster(
	rnd: RandomNumberGenerator, 
	cluster_radius: float) -> StarSystem:
	var new_cluster: StarSystem = _create_star_system(
			rnd, 
			Vector2(0,0), 
			cluster_radius)
#	while not new_cluster:
#		var spawn_position := (
#			Vector2.UP.rotated(rng.randf_range(0, PI * 2))
#			* rng.randf_range(min_distance_from_station, world_radius)
#		)
#		for cluster in get_children():
#			if (
#				spawn_position.distance_squared_to(cluster.position)
#				< pow(min_distance_between_clusters, 2)
#			):
#				continue
#		new_cluster = _create_cluster(rng, spawn_position)
#		break
	Events.emit_signal("star_system_is_spawned", new_cluster)
	return new_cluster


# Creates, initializes, and returns a new cluster with its asteroids pre-generated
func _create_star_system(
	rng: RandomNumberGenerator, 
	spawn_position: Vector2,
	cluster_radius: float) -> StarSystem:
	var cluster := StarSystem.new()
	add_child(cluster)
	cluster.setup(spawn_position)
	var planets = cluster.spawn_planets(rng, StarSystemSettings, cluster_radius)
	return cluster
