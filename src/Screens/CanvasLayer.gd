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
			#label.text = event.as_text()
		pass
	if event is InputEventMultiScreenDrag:
		#label2.text = "Multiple finger drag"		
		pass
	elif event is InputEventSingleScreenDrag:
		#label2.text = "Single finger drag"
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
		zoom_speed = 0
		zoom_factor = 0
	elif event is InputEventSingleScreenTouch:
		#label2.text = "Single finger touch"
		if (!event.pressed):
			speed = Vector2(0,0)
	return
