extends Area2D

var HP = 20
var my_color = null

func _ready():
	add_to_group("buildings")
	add_to_group("factories")

func capture(var damage, var attacker_color):
	HP -= damage
	if(HP>0):
		get_node("HP").set_text(str(HP))
	else:
		get_node("HP").set_text("")
		HP = 20
		# most of this is generalized now, but we still have to set up support for the building changing to the attacker's color building, not just the red one
		get_parent().set_cell((int(get_pos().x/16)*16)/16, (int(get_pos().y/16)*16)/16, 13)
		add_to_group(attacker_color)
		if(my_color!=null):
			remove_from_group(my_color)
		my_color = attacker_color
