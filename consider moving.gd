extends TileMap

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON and !event.is_pressed() and get_opacity() == 0.6):
		set_opacity(0)
		get_parent().move()