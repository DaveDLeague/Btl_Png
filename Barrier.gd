extends StaticBody2D

func _ready():
	set_process(true)
	update()

func _process(delta):
	pass
	
func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1024, 10)), Color(0, 1, 0, 1), false)
