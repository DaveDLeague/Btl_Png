extends Area2D

export var speed = 400
export var player = 1
export var margin = 100
export var color = Color(1, 0, 0, 1)

var width = 30
var height = 160
var hw = width / 2
var hh = height / 2


var playerString

var rect

var update = true;

func _ready():
	connect("area_entered", self, "on_collision")
	
	if player == 1:
		playerString = "left"
		position.x = margin
		color = Color(1, 0, 0.4, 1)
		
	elif player == 2:
		playerString = "right"
		position.x = get_viewport_rect().size.x - margin
		color = Color(0.4, 0, 1, 1)
	
	rect = Rect2(Vector2(-hw, -hh), Vector2(width, height))
	
	set_process(true)

func _process(delta):
	if Input.is_action_pressed(playerString + "_move_up"):
		position.y -= speed * delta
		update = true
		
	if Input.is_action_pressed(playerString + "_move_down"):
		position.y += speed * delta
		update = true
	
	if position.y < 11 + hh:
		position.y = 11 + hh
	elif position.y > get_viewport_rect().size.y - hh - 11:
		position.y = get_viewport_rect().size.y - hh - 11
	
	if update:
		update()
		update = false

func _draw():
	draw_rect(rect, color, true)

func on_collision(area):
	pass