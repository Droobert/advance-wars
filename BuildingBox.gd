extends Area2D

var HP = 20

func _ready():
	HP = 20
	add_to_group("buildings")
	add_to_group("blue")

func set_HP(var damage):
	HP -= damage
	if(HP>0):
		get_node("HP").set_text(str(HP))
	elif(is_in_group("buildings")):
		#if it's an HQ...
		if(true):
			get_node("HP").set_text("")
			HP = 20
			get_parent().set_cell((int(get_pos().x/8)*8)/8-1, (int(get_pos().y/8)*8)/8-3, 3)
			add_to_group("red")
		#set up logic for different buildings
	