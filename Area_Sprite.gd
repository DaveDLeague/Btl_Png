extends Sprite

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	
	update()
	
func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1)), Color(0, 0, 0, 1), true)

	for i in range(9):
		draw_rect(Rect2(Vector2(0.5 - 0.008, i * 0.1 + 0.1), Vector2(.01, .02)), Color(1, 1, 1, 1), true)