extends Camera2D
#class_name GameCamera

export var speed := Vector2()
export var zoom_factor := 0.0

export var move_speed = 0.5  # скорость камеры
export var zoom_speed = 0.25  # скорость зума
export var min_zoom = 1  # минимальная глубина увеличения
export var max_zoom = 10  # максимальная глубина увеличения
export var margin = Vector2(
	StarSystemSettings.Size/2, 
	StarSystemSettings.Size/2)  # include some buffer area around targets

#Приватные переменные
var selected:Node2D # отслеживание конкретной цели по мышке
var screen_is_scaled = false

onready var screen_size = get_viewport_rect().size #размер видимового экране

func _ready() -> void:
	Events.connect("planet_is_selected", self, "_on_object_is_selected")
	Events.connect("star_is_selected", self, "_on_object_is_selected")
	Events.connect("object_is_tracking", self, "_on_object_is_selected")
	Events.connect("star_system_is_spawned", self, "_on_star_system_is_spawned")

func _on_object_is_selected(object) -> void:
	selected = object

func _on_star_system_is_spawned(star_system) -> void:
	var targets: Array = []
	for _i in  star_system.get_children():
		if _i.is_class("Planet"):
			targets.append(_i)

	#var p = Vector2.ZERO
	#for target in targets:
	#	p += target.get_current_position()
	#	p /= targets.size()
	#	position = lerp(position, p, move_speed)

	var r = Rect2(position, Vector2.ONE)
	for target in targets:
		r = r.expand(target.get_current_position())
		r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
		var d = max(r.size.x, r.size.y)
		var z
		if r.size.x > r.size.y * screen_size.aspect():
			z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
		else:
			z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
		zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)


func _input(event) -> void:
	if (event is InputEventMultiScreenDrag or
		event is InputEventSingleScreenDrag or
		event is InputEventScreenPinch or
		event is InputEventScreenTwist or
		event is InputEventSingleScreenTap or
		event is InputEventSingleScreenTouch):
			# label.text = event.as_text()
			pass
	if event is InputEventMultiScreenDrag:
		# label2.text = "Multiple finger drag"		
		pass
	elif event is InputEventSingleScreenDrag:
		# label2.text = "Single finger drag"
		speed = event.speed
		# position = e.position
		# relative = e.relative
	elif event is InputEventScreenPinch:
		#label2.text = "Pinch"
		zoom_speed = event.speed / 40
		zoom_factor = event.relative / 25

	elif event is InputEventScreenTwist:
		#label2.text = "Twist"
		pass
	elif event is InputEventSingleScreenTap:
		#label2.text = "Single finger tap"
		Events.emit_signal("object_is_tracking", null)
		zoom_speed = 0
		zoom_factor = 0
	elif event is InputEventSingleScreenTouch:
		#label2.text = "Single finger touch"
		if (!event.pressed):
			speed = Vector2(0,0)
	return

func _process(delta) -> void:
	if selected :
		global_position = selected.get_current_position()

	position.x = lerp(position.x, position.x + speed.x*1*zoom.x, 1 * delta)
	position.y = lerp(position.y, position.y + speed.y*1*zoom.y, 1 * delta)
	#sky.set_offset(camera.position.x, camera.position.y)

	zoom.x = lerp(zoom.x, zoom.x + zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y + zoom_factor, zoom_speed * delta)
	
