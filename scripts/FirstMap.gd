extends TileMap
#constants
var SCREEN_WIDTH
var SCREEN_HEIGHT
#dictionaries to represent the underlying gamestate. We have to fill in any tiles that exist in the row just above the viewport.
var mapState = {}
var underState = {}
var unitLocations = {}
var buildingLocations = {}

func _ready():
	SCREEN_WIDTH = get_viewport_rect().size.x
	SCREEN_HEIGHT = get_viewport_rect().size.y
	#populate our mapState
	for i in range((SCREEN_HEIGHT/16)*(SCREEN_WIDTH/16)):
		mapState[i] = get_tileset().tile_get_name(get_cell(int(i%15), int(i/15)))
	#populate our underState
	for i in range((SCREEN_HEIGHT/16)*(SCREEN_WIDTH/16)):
		underState[i] = get_node("UnderMap").get_tileset().tile_get_name(get_node("UnderMap").get_cell(int(i%15), int(i/15)))
	#we have to doctor the mapState to adjust for 2-height tiles.
	#first, loop over the mapState backwards, pulling down the 2-height buildings, mountains, etc.
	#to do this, we need to iterate over the dictionary backwards.
	var keys = mapState.keys()
	keys.sort()
	var tile = ((SCREEN_HEIGHT/16)*(SCREEN_WIDTH/16)) -1
	while(tile>14):
		if(mapState[keys[tile]-15] == "redHQ"):
			mapState[keys[tile]] = "redHQ"
		if(mapState[keys[tile]-15] == "blueHQ"):
			mapState[tile] = "blueHQ"
		elif(mapState[keys[tile]-15] == "tallMountain A"):
			mapState[keys[tile]] = "tallMountain A"
		elif(mapState[keys[tile]-15] == "tallMountain B"):
			mapState[keys[tile]] = "tallMountain B"
		elif(mapState[keys[tile]-15] == "forest"):
			mapState[keys[tile]] = "forest"
		tile -= 1
	#we also have to pull down the top row manually
	mapState[0] = "tallMountain A"
	mapState[1] = "tallMountain A"
	mapState[2] = "tallMountain A"
	mapState[3] = "tallMountain A"
	#second, loop over the underState and send up all the revelant underState tiles to the mapState.
	for tile in underState:
		if(underState[tile]=="plains" or underState[tile] == "shadowyPlains"):
			mapState[tile] = underState[tile]
	#for tile in mapState:
	#	if(mapState[tile] == "tallMountain A"):
	#		set_cell(tile%15, tile/15, 12)
	# the HQ is 2 tiles tall on the tileset, but only exists in 1 space on the map, we need to adjust the mapState to reflect this
		#if(underState[tile] == "plains"):
				#if(mapState[tile] == "redHQ"):
		#	mapState[tile+15] = "redHQ"
		#	mapState[tile] = underState[tile] 
		#if(tile>=15 and mapState[tile-15] == "blueHQ"):
		#	mapState[tile] = "blueHQ"
		#	mapState[tile-15] = underState[tile-15]
		#if(mapState[tile] == "plains"):
		#	set_cell(tile%15, tile/15, 12)
	#set_cell(0, -1, -1)
	#set_cell(1, -1, -1)
	#set_cell(2, -1, -1)
	#set_cell(3, -1, -1)
	#for tile in mapState:
		#set_cell(tile%15, tile/15, -1)
		#if(mapState[tile] == "neutralFactory"):
		#	set_cell(tile%15, tile/15, 12)
	
func victory(var color):
	get_node("victoryBanner").set_text(color + " team victory!")

func get_HP(var building):
	return get_node(building).HP

#func _on_blueHQ_area_enter( area ):
#	if(area.get_parent().is_in_group("units")):
#		area.get_parent().occupied_building = "blueHQ"

# if the soldier moves off of the building, HP should be restored to full
func _on_blueHQ_area_exit( area ):
	if(get_node("blueHQ").HP < 20 and area.get_parent().is_in_group("units")):
		#area.get_parent().occupied_building = null
		get_node("blueHQ").HP = 20
		get_node("blueHQ/HP").set_text(str(""))

func _on_redHQ_area_exit( area ):
	if(get_node("redHQ").HP < 20 and area.get_parent().is_in_group("units")):
		#area.get_parent().occupied_building = null
		get_node("redHQ").HP = 20
		get_node("redHQ/HP").set_text(str(""))

# NEUTRAL FACTORY ENTER/EXIT EVENTS
#func _on_nf_A_area_enter( area ):
#	if(area.get_parent().is_in_group("units")):
#		area.get_parent().occupied_building = "nf A"

func _on_nf_A_area_exit( area ):
	if(get_node("nf A").HP < 20 and area.get_parent().is_in_group("units")):
		#area.get_parent().occupied_building = null
		get_node("nf A").HP = 20
		get_node("nf A/HP").set_text(str(""))

#func _on_nf_B_area_enter( area ):
#	if(area.get_parent().is_in_group("infantry")):
#		area.get_parent().occupied_building = "nf B"

func _on_nf_B_area_exit( area ):
	if(get_node("nf B").HP < 20 and area.get_parent().is_in_group("infantry")):
		get_node("nf B").HP = 20
		get_node("nf B/HP").set_text(str(""))

#func _on_nf_C_area_enter( area ):
#	if(area.get_parent().is_in_group("units")):
#		area.get_parent().occupied_building = "nf C"

func _on_nf_C_area_exit( area ):
	if(get_node("nf C").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nf C").HP = 20
		get_node("nf C/HP").set_text(str(""))

#func _on_nf_D_area_enter( area ):
#	if(area.get_parent().is_in_group("units")):
#		area.get_parent().occupied_building = "nf D"

func _on_nf_D_area_exit( area ):
	if(get_node("nf D").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nf D").HP = 20
		get_node("nf D/HP").set_text(str(""))
		

func _on_nc_A_area_exit( area ):
	if(get_node("nc A").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nc A").HP = 20
		get_node("nc A/HP").set_text(str(""))

func _on_nc_B_area_exit( area ):
	if(get_node("nc B").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nc B").HP = 20
		get_node("nc B/HP").set_text(str(""))

func _on_nc_C_area_exit( area ):
	if(get_node("nc C").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nc C").HP = 20
		get_node("nc C/HP").set_text(str(""))

func _on_nc_D_area_exit( area ):
	if(get_node("nc D").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("nc D").HP = 20
		get_node("nc D/HP").set_text(str(""))

func _on_rc_A_area_exit( area ):
	if(get_node("rc A").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("rc A").HP = 20
		get_node("rc A/HP").set_text(str(""))

func _on_rc_B_area_exit( area ):
	if(get_node("rc A").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("rc A").HP = 20
		get_node("rc A/HP").set_text(str(""))


func _on_rc_C_area_exit( area ):
	if(get_node("rc C").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("rc C").HP = 20
		get_node("rc C/HP").set_text(str(""))
		
func _on_bc_A_area_exit( area ):
	if(get_node("bc A").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("bc A").HP = 20
		get_node("bc A/HP").set_text(str(""))

func _on_bc_B_area_exit( area ):
	if(get_node("bc B").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("bc B").HP = 20
		get_node("bc B/HP").set_text(str(""))

func _on_bc_C_area_exit( area ):
	if(get_node("bc C").HP < 20 and area.get_parent().is_in_group("units")):
		get_node("bc C").HP = 20
		get_node("bc C/HP").set_text(str(""))
