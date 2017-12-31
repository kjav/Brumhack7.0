extends Node2D

export(int, "HealthPot", "StrengthPot", "SpeedPots, FireSpell, GrabSpell, FreezeSpell, CookedSteak, CookedChicken, Cheese") var type setget setType, getType

func setType(newType):
	type = newType
	if typeof(type) == TYPE_STRING:
		var instance
		if type == "HealthPot":
			instance = GameData.HealthPotion.instance()
		elif type == "StrengthPot":
			#unimplemented
			get_node("Description").add_text("This drink give you newfound strength!")
		elif type == "SpeedPot":
			#unimplemented
			get_node("Description").add_text("This drink increases your reaction speed!")
		elif type == "FireSpell":
			#unimplemented
			get_node("Description").add_text("Shoot a fire ball at the closest enemy!")
		elif type == "GrabSpell":
			#unimplemented
			get_node("Description").add_text("Collect the closest item to you!")
		elif type == "FreezeSpell":
			#unimplemented
			get_node("Description").add_text("Stop the closest enemy for a turn!")
		elif type == "CookedSteak":
			#unimplemented
			get_node("Description").add_text("Mmmh suculent steak...")
		elif type == "CookedChicken":
			#unimplemented
			get_node("Description").add_text("Chicken... down here? Don't complain!")
		elif type == "Cheese":
			#unimplemented
			get_node("Description").add_text("The cheese still kind of looks in date...")
		
		
		get_node("Name").set_text(instance.name)
		#needs changing
		get_node("ItemIcon").setImagee(type)
		#needs changing
		get_node("ItemDescription").setType(type)

func getType():
	return type