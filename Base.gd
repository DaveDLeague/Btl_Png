extends Area2D

export var color = Color(1, 1, 1, 1)

func _ready():
	update();

func _draw():
	draw_rect(Rect2(Vector2(-8, -288), Vector2(16, 576)), color, false)
