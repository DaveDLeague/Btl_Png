extends Area2D

export var baseNumber = 1
export var color = Color(1, 1, 1, 1)
export var health = 4.0
export var max_health = 4.0
export var damage = 1.0

signal hit_by_ball

func _ready():
	connect("area_entered", self, "on_collision")

func _draw():
	draw_rect(Rect2(Vector2(-8, -277), Vector2(16, 553)), color, true)
	if health <= 0:
		monitorable = false
		monitoring = false

func on_collision(area):
	if area.name == "Ball":
		health -= damage
		color.a = health/max_health
		update()
		
		emit_signal("hit_by_ball")