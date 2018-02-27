extends Area2D

onready var texture = find_node("Sprite")
onready var ptcl = find_node("Particles2D")

var angle
export var speed = 400
export var color = Color(1, 0, 1, 1)
var vel
#var col = []
func _ready():
	randomize()
	angle = 0#randi() % 360
	vel = Vector2(cos(angle) * speed, sin(angle) * speed)
	connect("area_entered", self, "on_collision")
	texture.modulate = color
	ptcl.process_material.color = color
	#col = []
	#col.push_back(Color(1, 0, 1, 0))
	#col.push_back(Color(1, 0, 1, 1))
	#col.push_back(Color(1, 0, 1, 1))
	set_process(true)

func _process(delta):
	position += vel * delta
	
	var w = get_viewport_rect().size.x - 10
	var h = get_viewport_rect().size.y - 10
	
	if position.y < 10:
		position.y = 10
	elif position.y > h:
		position.y = h
	if position.x < 10:
		position.x = 10
	elif position.x > w:
		position.x = w
	update()

func on_collision(area):
	if "Barrier" in  area.name:
		vel.y = -vel.y
	elif "Paddle" == area.name:
		var cen = area.get_position()
		var newVec = (position - cen).normalized()
		vel = newVec * speed
		speed += 15
		texture.modulate = area.color
		ptcl.process_material.color = area.color
	elif "Paddle2" == area.name:
		var cen = area.get_position()
		var newVec = (position - cen).normalized()
		vel = newVec * speed
		speed += 15
		texture.modulate = area.color
		ptcl.process_material.color = area.color
	elif "Base" in area.name:
		vel.x = -vel.x

func _draw():
	pass
	#var perp = Vector2(vel.y, -vel.x)
	#perp = perp.normalized() * 15
	#var tri = []
	#tri.push_back(-vel * 0.3)
	#tri.push_back(perp)
	#tri.push_back(-perp)
	#draw_polygon(tri, col)