extends Node2D

export(int, "HealthPot", "StrengthPot", "SpeedPots, FireSpell, GrabSpell, FreezeSpell, CookedSteak, CookedChicken, Cheese") var type setget setType, getType

func getType():
	return type

func setType(newType):
	if typeof(type) == typeof(0):
		if type == 0:
			get_node("Description").add_text("This drink heal your wounds!")
		elif type == 1:
			get_node("Description").add_text("This drink give you newfound strength!")
		elif type == 2:
			get_node("Description").add_text("This drink increases your reaction speed!")
		elif type == 3:
			get_node("Description").add_text("Shoot a fire ball at the closest enemy!")
		elif type == 4:
			get_node("Description").add_text("Collect the closest item to you!")
		elif type == 5:
			get_node("Description").add_text("Stop the closest enemy for a turn!")
		elif type == 6:
			get_node("Description").add_text("Mmmh suculent steak...")
		elif type == 7:
			get_node("Description").add_text("Chicken? down here... Don't complain!")
		elif type == 8:
			get_node("Description").add_text("The cheese still kind of looks in date...")