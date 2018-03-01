extends Particles2D

func _ready():
	emitting = true
	set_process(true)
	
func _process(delta):
	if !is_emitting():
		call_deferred("free")
