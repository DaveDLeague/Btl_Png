extends Sprite

onready var ball = get_parent().find_node("Ball")
onready var cam = get_parent().find_node("Camera2D")
onready var base1 = get_parent().find_node("Base")
onready var base2 = get_parent().find_node("Base2")

var camShake = false
var shakeTimer = 0

func game_over(player):
	print(player)

func base_hit(base):
	camShake = true
	shakeTimer = OS.get_ticks_msec()

func _ready():
	ball.connect("off_map", self, "game_over")
	ball.connect("hitBase", self, "base_hit")
	set_process(true)

func _process(delta):
	if camShake:
		randomize()
		cam.offset += Vector2(randf() - 0.5, randf() - 0.5) * delta * 250
		if OS.get_ticks_msec() - shakeTimer >= 500:
			camShake = false
			cam.offset = Vector2(0, 0)
		
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	
	update()
	
func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1)), Color(0, 0, 0, 1), true)

	for i in range(9):
		draw_rect(Rect2(Vector2(0.5 - 0.008, i * 0.1 + 0.1), Vector2(.01, .02)), Color(1, 1, 1, 1), true)