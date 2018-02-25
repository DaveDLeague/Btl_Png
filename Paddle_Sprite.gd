extends Sprite

export var color = Color(1, 0, 0, 1);

func _ready():
	pass
	
func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1)), color, true)