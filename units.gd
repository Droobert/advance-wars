
func consider_moving():
	#(animate the soldier while he is getting ready to move)
	#highlight walkable area: call for the consider moving tiles to appear
	get_node("HighlightMap").set_opacity(0.6)
	#higlight attackable enemies

func _on_Hitbox_input_event( viewport, event, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		consider_moving()