extends AnimatedSprite

var HP = 10

func _ready():
	# connect the event for _on_click to listen for when the soldier is clicked on
	#get_node("Area2D").connect("pressed", self, "_on_click")
	add_to_group("units")
	add_to_group("blue")
	get_parent().unitState[get_name()] = occupied_tile()
	set_process(true)

func move():
	var mouse = get_viewport().get_mouse_pos()
	mouse.x = int(mouse.x/16)*16+8
	mouse.y = int(mouse.y/16)*16+8
	if(mouse.x < get_viewport_rect().size.x and mouse.y < get_viewport_rect().size.y):
		set_pos(mouse)
		get_parent().get_node("Timer").start()
		yield(get_parent().get_node("Timer"), "timeout")
	command_menu()

func occupied_tile():
	return((int(get_pos().x/16)*16)%15+(int(get_pos().y/16)*16)/15)

func consider_moving():
	#(animate the soldier while he is getting ready to move)
	#highlight walkable area: call for the consider moving tiles to appear
	get_node("UnitMaps/HighlightMap").set_opacity(0.6)
	#higlight attackable enemies


func command_menu():
	#bring up the command menu
	get_node("Command List").popup()

func _on_Hitbox_input_event( viewport, event, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		consider_moving()
