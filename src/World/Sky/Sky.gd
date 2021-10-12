extends ColorRect

class_name StarSky

export var scroll_scale = 1

func resize(size) -> void:
	rect_size = size
	material.set_shader_param("viewport_size", size)

func set_offset(x_offset, y_offset) -> void:
	material.set_shader_param("x_offset", x_offset * scroll_scale)
	material.set_shader_param("y_offset", y_offset * scroll_scale)
	
