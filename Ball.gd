extends Node2D

onready var sprite = find_node("Ball_Sprite")

export var speed = 5
export var startAngle = 0
export var color = Color(1, 0, 1, 1)
export var radius = 15

var angle

func _ready():
	set_process(true)
	sprite.color = color;
	sprite.radius = radius;

func _process(delta):
	pass
