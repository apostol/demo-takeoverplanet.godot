extends Area2D
class_name PlanetView

signal planet_is_touching(planet, time_left)
signal planet_is_selected(planet)
signal planet_bot_launched(planet, target_position, bot_count)

onready var sprite := get_node("Animation")
onready var collision: CollisionShape2D = get_node("CollisionShape2D")

var time_left = 0.0
var pressed = false
var angle_is_calculating = true
var model #??????

func setup(rnd, model) -> void:
	self.model = model
	self.model.connect("planet_scale_changed", self, "_on_planet_scale_changed")
	rotate(model.planet_rotate)
	
	sprite.setup(rnd, model.planet_orbit, model.planet_scale)
	collision.translate(model.planet_orbit)
	collision.scale = Vector2(model.planet_scale, model.planet_scale)

func get_current_position() -> Vector2:
	return sprite.get_global_transform().get_origin()

func _on_planet_scale_changed(value) -> void:
	sprite.scale = Vector2(value,value)
	pass

func _process(delta):
	#rotation += model.planet_speed * delta
	if pressed && angle_is_calculating:
		if sprite.draw_layer.arc_angle_fill<=get_angle_to_show_ship_count():
			time_left += delta
			sprite.draw_layer.arc_angle_fill = 72*time_left
		emit_signal("planet_is_touching", get_parent(), time_left)
	sprite.draw_layer.arc_angle_ship = get_angle_to_show_ship_count()

func _input(event) -> void:
	if event is InputEventSingleScreenTap:
		if (sprite.touch_rect.has_point(sprite.offset - sprite.get_local_mouse_position())):
			emit_signal("planet_is_selected", get_parent())
			get_tree().set_input_as_handled()
	if event is InputEventSingleScreenTouch:
		if model.planet_owner:
			if sprite.touch_rect.has_point(sprite.offset - sprite.get_local_mouse_position()):
				pressed = event.pressed
				time_left = 0
				if pressed:
					sprite.draw_layer.isEnabled = true
					angle_is_calculating = true
				else:
					sprite.draw_layer.arc_angle_fill = 0
					angle_is_calculating = false
					sprite.draw_layer.isEnabled = false
			else:
				if not angle_is_calculating &&  sprite.draw_layer.isEnabled:
					emit_signal(
						"planet_bot_launched", 
						get_parent(), 
						sprite.get_global_mouse_position(), 
						get_ship_count_to_send())
					sprite.draw_layer.arc_angle_fill = 0
					sprite.draw_layer.isEnabled = false
	if event is InputEventSingleScreenDrag:
		angle_is_calculating = false

func get_ship_count_to_send() -> int:
	return int(model.planet_ship_amount*sprite.draw_layer.arc_angle_fill/sprite.draw_layer.arc_angle_ship)

func get_angle_to_show_ship_count() -> float:
	return float(360 * model.planet_ship_amount / model.planet_max_ship_amount)
