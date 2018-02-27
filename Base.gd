extends Area2D

export var color = Color(1, 1, 1, 1)
export var health = 4.0
export var max_health = 4.0
export var damage = 1.0

func _ready():
	#update()
	connect("area_entered", self, "on_collision")

func _draw():
	draw_rect(Rect2(Vector2(-8, -277), Vector2(16, 553)), color, false)

func on_collision(area):
	if area.name == "Ball":
		health -= damage
		color = Color(1, 1, 1, health/max_health)
		update()
		if health <= 0:
			call_deferred("free")