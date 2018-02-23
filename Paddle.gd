extends Node2D

export var player = 1
export var speed = 300
export var margin = 100

onready var sprite = find_node("Sprite")
var plrStr
var updateGraphics = true;

func _process(delta):
	if Input.is_action_pressed(plrStr + "_move_up"):
		position.y -= speed * delta;
		updateGraphics = true;
	if Input.is_action_pressed(plrStr + "_move_down"):
		position.y += speed * delta;
		updateGraphics = true;
	
	var ht = get_viewport_rect().size.y - sprite.scale.y
	
	if position.y < 0: 
		position.y = 0
	elif position.y > ht:
		position.y = ht
		
	if updateGraphics:
		sprite.update()
		updateGraphics = false;

func _ready():
	if player == 1:
		plrStr = "left"
		sprite.color = Color(1, 0, 0, 1)
		position.x = margin
		
	elif player == 2:
		plrStr = "right"
		sprite.color = Color(0, 0, 1, 1)
		position.x = get_viewport_rect().size.x - margin
	set_process(true);