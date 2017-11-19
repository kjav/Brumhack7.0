extends Node2D

export(int, "HealthPot", "StrengthPot", "SpeedPots, FireSpell, GrabSpell, FreezeSpell, CookedSteak, CookedChicken, Cheese") var type setget setType, getType

var healthPot = preload("res://assets//red_potion2.png")
var strengthPot = preload("res://assets//green_potion2.png")
var speedPot = preload("res://assets//lightblue_potion2.png")

var fireSpell = preload("res://assets//red_spell2.png")
var grabSpell = preload("res://assets//purple_spell2.png")
var freezeSpell = preload("res://assets//blue_spell2.png")

var cookedSteak = preload("res://assets//cooked_steak2.png")
var cookedChicken = preload("res://assets//meat.png")
var cheese = preload("res://assets//cheese.png")

func setType(newType):
	if typeof(type) == typeof(0):
		if type == 0:
			get_node("Icon").set_texture(healthPot)
		elif type == 1:
			get_node("Icon").set_texture(strengthPot)
		elif type == 2:
			get_node("Icon").set_texture(speedPot)
		elif type == 3:
			get_node("Icon").set_texture(fireSpell)
		elif type == 4:
			get_node("Icon").set_texture(grabSpell)
		elif type == 5:
			get_node("Icon").set_texture(freezeSpell)
		elif type == 6:
			get_node("Icon").set_texture(cookedSteak)
		elif type == 7:
			get_node("Icon").set_texture(cookedChicken)
		elif type == 8:
			get_node("Icon").set_texture(cheese)

func getType():
	return type