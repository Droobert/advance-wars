extends Area2D

var HP = 20
var my_color

func _ready():
#	HP = 20
	add_to_group("buildings")
	add_to_group("HQ")
	add_to_group("red")
	my_color = "red"
	get_parent().buildingLocations[get_location()] = get_name()
	#get_parent().set_cell((int(get_pos().x/16)*16)%15, (int(get_pos().y/16)*16)/15, 6)

func get_location():
	return((int(get_pos().x/16)*16)/16+((int(get_pos().y/16)*16)/16)*15)

func capture(var damage, var attacker_color):
	HP -= damage
	if(HP>0):
		get_node("HP").set_text(str(HP))
	#elif(is_in_group("buildings")):
	else:
		#if it's an HQ...
		#it's always an HQ now because I made a seperate HQ file
		#if(is_in_group("HQ")):
		get_node("HP").set_text("")
		HP = 20
		# most of this is generalized now, but we still have to set up support for the building changing to the attacker's color building, not just the red one
		if(attacker_color == "red"):
			get_parent().set_cell((int(get_pos().x/16)*16)/16, (int(get_pos().y/16)*16)/16-1, 3)
		elif(attacker_color == "blue"):
			get_parent().set_cell((int(get_pos().x/16)*16)/16, (int(get_pos().y/16)*16)/16-1, 4)
		
		add_to_group(attacker_color)
		remove_from_group(my_color)
		my_color = attacker_color
		#for HQ in group("HQ"):
		#if(get_tree().call_group(0, "HQ", "all_HQ_controlled", attacker_color)):
		get_parent().victory(attacker_color)

#func all_HQ_controlled(var color):
#	if(color != my_color):
#		return false