class_name PlanetDrawLayer
extends Node2D

export var isEnabled = false

var radius: float
export var arc_angle_fill: float = 0.0
export var arc_angle_ship: float = 0.0

func setup(radius: float)-> void:
	self.radius = radius
	print_debug(radius)

func _process(delta):
	update()

func _draw():
	var color: Color
	if isEnabled:
		color = Color(1.0, 0.0, 0.0)
		draw_circle_arc(position, radius, 0, arc_angle_fill, color)

	color = Color(0.0, 1.0, 0.0)
	draw_circle_arc(position, radius-10, 0, arc_angle_ship, color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 360
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
