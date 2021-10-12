extends CanvasLayer

onready var label: Label = get_node("Label")
onready var label2: Label = get_node("Label2")

var speed := Vector2()
var zoom_speed := 0.0
var zoom_factor := 0.0

func _input(event) -> void:
	if (event is InputEventMultiScreenDrag or
		event is InputEventSingleScreenDrag or
		event is InputEventScreenPinch or
		event is InputEventScreenTwist or
		event is InputEventSingleScreenTap or
		event is InputEventSingleScreenTouch):
			label.text = event.as_text()
	if event is InputEventMultiScreenDrag:
		label2.text = "Multiple finger drag"		
	elif event is InputEventSingleScreenDrag:
		label2.text = "Single finger drag"
		speed = event.speed
		# position = e.position
		# relative = e.relative
	elif event is InputEventScreenPinch:
		label2.text = "Pinch"
		zoom_speed = event.speed / 40
		zoom_factor = event.relative / 25

	elif event is InputEventScreenTwist:
		label2.text = "Twist"
	elif event is InputEventSingleScreenTap:
		label2.text = "Single finger tap"
		zoom_speed = 0
		zoom_factor = 0
	elif event is InputEventSingleScreenTouch:
		label2.text = "Single finger touch"
		if (!event.pressed):
			speed = Vector2(0,0)
	return

func _process(delta) -> void:
	# camera.position.x = lerp(camera.position.x, camera.position.x + speed.x*1*camera.zoom.x, 1 * delta)
	# camera.position.y = lerp(camera.position.y, camera.position.y + speed.y*1*camera.zoom.y, 1 * delta)
	# sky.set_offset(camera.position.x, camera.position.y)
	
	# camera.zoom.x = lerp(camera.zoom.x, camera.zoom.x + zoom_factor, zoom_speed * delta)
	# camera.zoom.y = lerp(camera.zoom.y, camera.zoom.y + zoom_factor, zoom_speed * delta)
	pass
	
