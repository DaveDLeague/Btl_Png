extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)

func _process(delta):
	update()
	
func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1)), Color(1, 0, 1, 1), false)
