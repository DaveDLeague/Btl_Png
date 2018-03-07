extends StaticBody2D

export var baseNumber = 1
export var color = Color(1, 1, 1, 1)
export var health = 4.0
export var max_health = 4.0
export var damage = 1.0

onready var cbox = find_node("CollisionShape2D")
onready var ball = get_parent().find_node("Ball")
onready var ext = cbox.shape.extents

signal hit_by_ball

func _ready():
	ball.connect("hitBase", self, "on_collision")

func _draw():
	draw_rect(Rect2(-ext, ext * 2), color, true)
	if health <= 0:
		pass

func on_collision(base):
	if base == baseNumber:
		health -= damage
		color.a = health/max_health
		update()
		if health <= 0:
			add_collision_exception_with(ball)