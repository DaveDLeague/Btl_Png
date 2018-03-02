extends Area2D

onready var crash = find_node("CrashStreamPlayer")
onready var boop = find_node("BoopStreamPlayer")
onready var pew = find_node("PewStreamPlayer")
onready var texture = find_node("Sprite")
onready var ptcl = find_node("Particles2D")
onready var clshp = find_node("CollisionShape2D")
onready var barPtcl = preload("res://BarrierParticles2D.tscn")
onready var padPtcl = preload("res://PaddleParticles2D.tscn")
onready var pad2Ptcl = preload("res://Paddle2Particles2D.tscn")

var angle
export var speed = 400
export var color = Color(1, 0, 1, 1)

onready var base1 = get_parent().find_node("Base")
onready var base2 = get_parent().find_node("Base2")

signal off_map(winner)

var vel
var startPos

func _ready():
	angle = 0
	vel = Vector2(cos(angle) * speed, sin(angle) * speed)
	startPos = position
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
		
	if position.x <= 10 && base1.health > 0:
		position.x = 11
	elif position.x >= w && base2.health > 0:
		position.x = w - 1	
	elif position.x < -20:
		emit_signal("off_map", "player2")
		position = startPos
		vel = Vector2(0, 0)
	elif position.x > get_viewport_rect().size.x + 20:
		emit_signal("off_map", "player1")
		position = startPos
		vel = Vector2(0, 0)

func on_collision(area):
	speed += 10
	
	if "Barrier" in  area.name:
		vel.y = -vel.y
		add_child(barPtcl.instance())
		boop.play()
	elif "Paddle" == area.name:
		texture.modulate = area.color
		ptcl.process_material.color = area.color
		position -= vel.normalized() * speed * 0.02
		var cen = area.get_position()
		pew.play()
		if position.x < cen.x && vel.x > 0:
			position = cen + Vector2(20, 0)
			vel = Vector2(1, 0) * speed
			add_child(padPtcl.instance())
			return
		var newVec = (position - cen).normalized()
		vel = newVec * speed
		texture.modulate = area.color
		ptcl.process_material.color = area.color
		add_child(padPtcl.instance())
		
	elif "Paddle2" == area.name:
		texture.modulate = area.color
		ptcl.process_material.color = area.color
		position -= vel.normalized() * speed * 0.02
		var cen = area.get_position()
		pew.play()
		if position.x > cen.x && vel.x < 0:
			position = cen - Vector2(20, 0)
			vel = Vector2(-1, 0) * speed
			add_child(pad2Ptcl.instance())
			return
		var newVec = (position - cen).normalized()
		vel = newVec * speed
		add_child(pad2Ptcl.instance())
	elif "Base2" == area.name:
		crash.play()
		vel.x = -vel.x
		add_child(pad2Ptcl.instance())
	elif "Base" == area.name:
		crash.play()
		vel.x = -vel.x
		add_child(padPtcl.instance())