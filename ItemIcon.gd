extends Node2D

export(int, "HealthPot", "StrengthPot", "SpeedPots", "FireSpell", "GrabSpell", "FreezeSpell", "CookedSteak", "CookedChicken", "Cheese") var type setget setType, getType

var healthPot = preload("res://assets/red_potion2.png")
var strengthPot = preload("res://assets/green_potion2.png")
var speedPot = preload("res://assets/lightblue_potion2.png")

var fireSpell = preload("res://assets/red_spell2.png")
var grabSpell = preload("res://assets/purple_spell2.png")
var freezeSpell = preload("res://assets/blue_spell2.png")

var cookedSteak = preload("res://assets/cooked_steak2.png")
var cookedChicken = preload("res://assets/meat.png")
var cheese = preload("res://assets/cheese2.png")

func setType(newType):
	type = newType
	if typeof(type) == TYPE_STRING:
		if type == "HealthPot":
			get_node("Icon").set_texture(healthPot)
		elif type == "StrengthPot":
			get_node("Icon").set_texture(strengthPot)
		elif type == "SpeedPot":
			get_node("Icon").set_texture(speedPot)
		elif type == "FireSpell":
			get_node("Icon").set_texture(fireSpell)
		elif type == "GrabSpell":
			get_node("Icon").set_texture(grabSpell)
		elif type == "FreezeSpell":
			get_node("Icon").set_texture(freezeSpell)
		elif type == "CookedSteak":
			get_node("Icon").set_texture(cookedSteak)
		elif type == "CookedChicken":
			get_node("Icon").set_texture(cookedChicken)
		elif type == "Cheese":
			get_node("Icon").set_texture(cheese)

func getType():
	return type