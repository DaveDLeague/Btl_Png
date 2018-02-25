extends Sprite

var radius = 25
var color = Color(1, 0, 1, 1)

func _ready():
	update()

func _draw():
	draw_circle(Vector2(0, 0), radius, color)
