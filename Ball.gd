extends Area2D

onready var texture = find_node("Sprite")
onready var ptcl = find_node("Particles2D")
onready var clshp = find_node("CollisionShape2D")
onready var barPtcl = preload("res://BarrierParticles2D.tscn")


var angle
export var speed = 400
export var color = Color(1, 0, 1, 1)

var base1Active = true
var base2Active = true

var vel

func _ready():
	#randomize()
	#barPtcl = find_node("BarrierParticles2D")
	angle = 0
	vel = Vector2(cos(angle) * speed, sin(angle) * speed)
	connect("area_entered", self, "on_collision")
	texture.modulate = color
	ptcl.process_material.color = color
	set_process(true)

func _process(delta):
	position += vel * delta
	
	var w = get_viewport_rect().size.x - 10
	var h = get_viewport_rect().size.y - 10
	
	if position.y <= 10:
		position.y = 11
	elif position.y >= h:
		position.y = h - 1

func on_collision(area):
	speed += 10
	
	if "Barrier" in  area.name:
		vel.y = -vel.y
		add_child(barPtcl.instance())
	elif "Paddle" == area.name:
		texture.modulate = area.color
		ptcl.process_material.color = area.color
		position -= vel.normalized() * speed * 0.01
		var cen = area.get_position()
		if position.x < cen.x && vel.x > 0:
			position = cen + Vector2(20, 0)
			vel = Vector2(1, 0) * speed
			return
		var newVec = (position - cen).normalized()
		vel = newVec * speed
		texture.modulate = area.color
		ptcl.process_material.color = area.color
	elif "Paddle2" == area.name:
		texture.modulate = area.color
		ptcl.process_material.color = area.color
		position -= vel.normalized() * speed * 0.01
		var cen = area.get_position()
		if position.x > cen.x && vel.x < 0:
			position = cen - Vector2(20, 0)
			vel = Vector2(-1, 0) * speed
			return
		var newVec = (position - cen).normalized()
		vel = newVec * speed
	elif "Base2" == area.name:
		vel.x = -vel.x
		if area.health <= 0:
			base1Active = false
		
	elif "Base" == area.name:
		vel.x = -vel.x
		if area.health <= 0:
			base1Active = false