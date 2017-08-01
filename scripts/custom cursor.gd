extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	
func _process(delta):
	var mouse = get_viewport().get_mouse_pos()
	mouse.x = int(mouse.x/8)*8
	mouse.y = int(mouse.y/8)*8
	set_pos(mouse)
	
