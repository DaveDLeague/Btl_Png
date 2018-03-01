extends Sprite

func _ready():
	update();

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1)), Color(0, 1, 0, 1), true)
