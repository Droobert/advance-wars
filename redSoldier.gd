extends AnimatedSprite

#var name = "redSoldier"
var HP = 10
#var occupied_building = null
var color = "red"

var matchups = {
	"tank" : 50
}

func _ready():
	# connect the event for _on_click to listen for when the soldier is clicked on
	#get_node("Area2D").connect("pressed", self, "_on_click")
	add_to_group("units")
	add_to_group("infantry")
	add_to_group("red")
	get_parent().unitLocations[get_location()] = get_name()
	set_process(true)

func get_location():
	return((int(get_pos().x/16)*16)/16+((int(get_pos().y/16)*16)/16)*15)
	
func consider_moving():
	#(animate the soldier while he is getting ready to move)
	#highlight walkable area: call for the consider moving tiles to appear
	get_node("UnitMaps/HighlightMap").set_opacity(0.6)
	#we should do a modified bfs/dijkstra-ish search here to determine which of our movement tiles should be valid options and disable the others
	#higlight attackable enemies (based on looking at neighbors of the tiles we can move to?)

func move():
	var pre_move_location = get_location()
	var mouse = get_viewport().get_mouse_pos()
	mouse.x = int(mouse.x/16)*16+8
	mouse.y = int(mouse.y/16)*16+8
	if(mouse.x < get_viewport_rect().size.x and mouse.y < get_viewport_rect().size.y):
		set_pos(mouse)
		get_parent().get_node("Timer").start()
		yield(get_parent().get_node("Timer"), "timeout")
	if(get_location() != pre_move_location):
		get_parent().unitLocations.erase(pre_move_location)
		get_parent().unitLocations[get_location()] = get_name()
	#get_parent().set_cell((int(get_pos().x/16)*16)/16, ((int(get_pos().y/16)*16)/16), -1)
	#get_parent().set_cell(11, 1, -1)
	command_menu()

func occupied_building():
	if(get_parent().buildingLocations.has(get_location())):
		return get_parent().get_node(get_parent().buildingLocations[get_location()])
#func check_for_building():
	#var on_a_building = false
#	var pos = get_pos()
#	get_tree().call_group(0, "buildings", "occupies_building", get_name(), pos)
	#for building in get_parent().get_groups("buildings"):
	#	if(intersects(building)):
	#		occupied_building = building
	#		on_a_building = true
	#if(!on_a_building):
	#	occupied_building = null


func flip():
	if(is_flipped_h()):
		set_flip_h(false)
	else:
		set_flip_h(true)

func command_menu():
	#bring up the command menu
	get_node("Command List").popup()


func fire(var target):
	# deal the unit's damage to the target
	target.HP -= int(matchups[target.get_name()]*(float(HP/10)))
	# how are we going to deal damage to the targeted oponent?
	# (damage is based on terrain, unit type, and current HP)
	# (counter-attacks deal damage as well!)
	#if our guys die they need to be removed from unitLocations

func capture():
	# subtract the infantry unit's HP from the building's HP
	#get_parent().get_node(occupied_building).capture(HP, color)
	occupied_building().capture(HP, color)

func _on_Hitbox_input_event( viewport, event, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		consider_moving()
		#take_turn()

func _on_Command_List_about_to_show():
	#flip the command list to the opposite side of the screen from the mouse, to make it easier to see the battlefield
	if(get_pos().x > get_viewport_rect().size.x/2):
		get_node("Command List").set_margin(0, 5)
		get_node("Command List").set_margin(2, 10)
	if(get_pos().x < get_viewport_rect().size.x/2):
		get_node("Command List").set_margin(2, 295)
		get_node("Command List").set_margin(0, 290)
	# evaluate if capture or fire should be options
	#soldier units should check the surrounding 4 tiles for targets to fire on
	#if no targets are found, disable the fire command
	if(true):
		get_node("Command List").set_item_disabled(0, true)
	#if unit is on a building...
	#if(occupied_building != null):
	if(get_parent().buildingLocations.has(get_location())):
		#disable capture if the building is on the same team
		#if(get_parent().get_node(occupied_building).is_in_group(color)):
		if(occupied_building().is_in_group(color)):
			get_node("Command List").set_item_disabled(1, true)
		#enable capture if the building is not on the same team
		else:
			get_node("Command List").set_item_disabled(1, false)
	#else disable capture since the unit is not on a building
	else:
		get_node("Command List").set_item_disabled(1, true)

func _on_Command_List_item_pressed( ID ):
	if(ID == 0):
		fire()
	elif(ID == 1):
		capture()
