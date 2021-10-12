extends AnimatedSprite

export var touch_rect: Rect2
export var size: Vector2

onready var draw_layer: PlanetDrawLayer = get_node("DrawLayer")

func setup(rnd: RandomNumberGenerator, offset, scale: float)-> void:
	translate(offset)
	#рассчитаем зону клика для анимации
	self.scale = Vector2(scale,scale)
	var frame = self.frames.get_frame("default",0)
	size = frame.get_size()
	touch_rect = Rect2(Vector2.ZERO-size/2, size)
	draw_layer.setup(size.length()/2)



