extends Area2D

onready var texture = find_node("Sprite")

var angle
export var speed = 400
var vel

func _ready():
	randomize()
	angle = 0#randi() % 360
	vel = Vector2(cos(angle) * speed, sin(angle) * speed)
	connect("area_entered", self, "on_collision")
	texture.modulate = Color(1, 0, 0, 1)
	set_process(true)

func _process(delta):
	position += vel * delta
	
	if position.y < 10:
		position.y = 10
	elif position.y > get_viewport_rect().size.y - 10:
		position.y = get_viewport_rect().size.y - 10

func on_collision(area):
	if "Barrier" in  area.name:
		vel.y = -vel.y
	if "Paddle" in area.name:
		var cen = area.get_position()
		var newVec = (position - cen).normalized()
		vel = newVec * speed