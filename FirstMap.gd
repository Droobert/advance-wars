extends TileMap
#constants
var SCREEN_WIDTH
var SCREEN_HEIGHT 
#dictionary to represent the underlying gamestate
var gameState = {0:"tallMountain A", 1:"tallMountain A", 2:"tallMountain A", 3:"tallMountain A"}
var underState = {}

func _ready():
	SCREEN_WIDTH = get_viewport_rect().size.x
	SCREEN_HEIGHT = get_viewport_rect().size.y
	#populate our gameState
	for i in range((SCREEN_HEIGHT/16)*(SCREEN_WIDTH/16)):
		gameState[i] = get_tileset().tile_get_name(get_cell(int(i%15), int(i/15)))
	#populate our underState
	for i in range((SCREEN_HEIGHT/16)*(SCREEN_WIDTH/16)):
		underState[i] = get_node("UnderMap").get_tileset().tile_get_name(get_node("UnderMap").get_cell(int(i%15), int(i/15)))
	#we have to doctor the gameState to adjust for 2-height tiles.
	#first, loop over the gameState backwards, pulling down the 2-height buildings, mountains, etc.
	#second, loop over the underState and send up all the underState tiles to the gameState so the gameState jives with the appearance of the map.
	for tile in gameState:
		set_cell(tile%15, tile/15, -1)
		#if(gameState[tile] == "neutralFactory"):
		#	set_cell(tile%15, tile/15, 12)
		# the HQ is 2 tiles tall on the tileset, but only exists in 1 space on the map, we need to adjust the gameState to reflect this
		#if(gameState[tile] == "redHQ"):
		#	gameState[tile+15] = "redHQ"
		#	gameState[tile] = underState[tile] 
		#if(tile>=15 and gameState[tile-15] == "blueHQ"):
		#	gameState[tile] = "blueHQ"
		#	gameState[tile-15] = underState[tile-15]
		#if(gameState[tile] == "plains"):
		#	set_cell(tile%15, tile/15, 12)
	set_cell(0, -1, -1)
	set_cell(1, -1, -1)
	set_cell(2, -1, -1)
	set_cell(3, -1, -1)
	for tile in gameState:
		if(underState[tile] == "plains"):
			get_node("UnderMap").set_cell(tile%15, tile/15, 8)
		
		#pass

func victory(var color):
	get_node("victoryBanner").set_text(color + "team victory!")

func get_HP(var building):
	return get_node(building).HP

func _on_blueHQ_area_enter( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = "blueHQ"

# if the soldier moves off of the building, HP should be restored to full
func _on_blueHQ_area_exit( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = null
		get_node("blueHQ").HP = 20
		get_node("blueHQ/HP").set_text(str(""))

# NEUTRAL FACTORY ENTER/EXIT EVENTS
func _on_nf_A_area_enter( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = "nf A"

func _on_nf_A_area_exit( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = null
		get_node("nf A").HP = 20
		get_node("nf A/HP").set_text(str(""))

func _on_nf_B_area_enter( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = "nf B"

func _on_nf_B_area_exit( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = null
		get_node("nf B").HP = 20
		get_node("nf B/HP").set_text(str(""))

func _on_nf_C_area_enter( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = "nf C"

func _on_nf_C_area_exit( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = null
		get_node("nf C").HP = 20
		get_node("nf C/HP").set_text(str(""))

func _on_nf_D_area_enter( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = "nf D"

func _on_nf_D_area_exit( area ):
	if(area.get_parent().is_in_group("units")):
		area.get_parent().occupied_building = null
		get_node("nf D").HP = 20
		get_node("nf D/HP").set_text(str(""))
		