extends StaticBody2D

onready var cbox = find_node("CollisionShape2D")
onready var ext = cbox.shape.extents

func _ready():
	update()

func _draw():
	draw_rect(Rect2(-ext, ext * 2), Color(0, 1, 0, 1), true)
