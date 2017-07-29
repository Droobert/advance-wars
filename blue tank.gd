extends AnimatedSprite

func _ready():
	# connect the event for _on_click to listen for when the soldier is clicked on
	#get_node("Area2D").connect("pressed", self, "_on_click")
	add_to_group("units")
	add_to_group("blue")
	set_process(true)

func consider_moving():
	#(animate the soldier while he is getting ready to move)
	#highlight walkable area: call for the consider moving tiles to appear
	get_node("HighlightMap").set_opacity(0.6)
	#higlight attackable enemies


func command_menu():
	#bring up the command menu
	get_node("Command List").popup()

func _on_Hitbox_input_event( viewport, event, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		consider_moving()
