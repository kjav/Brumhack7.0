extends Node2D

export(int, "HealthPot", "StrengthPot", "SpeedPots, FireSpell, GrabSpell, FreezeSpell, CookedSteak, CookedChicken, Cheese") var type setget setType, getType

func setType(newType):
	type = newType
	if typeof(type) == TYPE_STRING:
		get_node("ItemIcon").setType(type)
		get_node("ItemDescription").setType(type)

func getType():
	return type

func _pressed():
	#do stuff for consumption