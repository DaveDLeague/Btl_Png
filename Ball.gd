extends RigidBody2D

onready var crash = find_node("CrashStreamPlayer")
onready var boop = find_node("BoopStreamPlayer")
onready var pew = find_node("PewStreamPlayer")
onready var texture = find_node("Sprite")
onready var ptcl = find_node("Particles2D")
onready var barPtcl = preload("res://BarrierParticles2D.tscn")
onready var padPtcl = preload("res://PaddleParticles2D.tscn")
onready var pad2Ptcl = preload("res://Paddle2Particles2D.tscn")

signal off_map(winner)
signal hitBase(base)

var angle
var startPos
export var speed = 500
export var color = Color(1, 0, 1, 1)

func _ready():
	angle = 0
	startPos = position
	texture.modulate = color
	ptcl.process_material.color = color
	apply_impulse(Vector2(), Vector2(speed, 0))

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.name == "Paddle2":
			color = body.color
			texture.modulate = body.color
			ptcl.process_material.color = body.color
			var vec = (position - body.position).normalized()
			var p2 = pad2Ptcl.instance()
			p2.position -= vec * 15
			add_child(p2)
			speed += 10
			linear_velocity = vec * speed
			
		elif body.name == "Paddle":
			color = body.color
			texture.modulate = body.color
			ptcl.process_material.color = body.color
			var vec = (position - body.position).normalized()
			var p2 = padPtcl.instance()
			p2.position -= vec * 15
			add_child(p2)
			speed += 10
			linear_velocity = vec * speed
			
		elif body.name == "Base":
			if body.color.r != color.r:
				emit_signal("hitBase", 1)
				var p2 = padPtcl.instance()
				p2.position -= Vector2(15, 0)
				add_child(p2)
		elif body.name == "Base2":
			if body.color.b != color.b:
				emit_signal("hitBase", 2)
				var p2 = pad2Ptcl.instance()
				p2.position += Vector2(15, 0)
				add_child(p2)
		elif body.name == "Barrier":
			var p2 = barPtcl.instance()
			p2.position -= Vector2(0, 15)
			add_child(p2)
		elif body.name == "Barrier2":
			var p2 = barPtcl.instance()
			p2.position += Vector2(0, 15)
			add_child(p2)	
	
	var ww = get_viewport_rect().size.x
	var hh = get_viewport_rect().size.y
	
	if position.x < -10 || position.x > ww + 10 || position.y < -10 || position.y > hh + 10 :
		position = startPos