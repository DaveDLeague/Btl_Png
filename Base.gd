extends StaticBody2D

export var baseNumber = 1
export var color = Color(1, 1, 1, 1)
export var health = 4.0
export var max_health = 4.0
export var damage = 1.0

onready var ball = get_parent().find_node("Ball")

signal hit_by_ball

func _ready():
	ball.connect("hitBase", self, "on_collision")

func _draw():
	draw_rect(Rect2(Vector2(-8, -277), Vector2(16, 553)), color, true)
	if health <= 0:
		pass

func on_collision(base):
	if base == baseNumber:
		health -= damage
		if health <= 0:
			add_collision_exception_with(ball)
		color.a = health/max_health
		update()
		