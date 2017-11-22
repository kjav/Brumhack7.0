extends Node

var potions = []
var food = []
var spells = []
var tilemap
var character
var enemies = []

func _ready():
	addPotions(["HealthPot", "StrengthPot", "StrengthPot", "HealthPot", "SpeedPot"])
	addFoods(["Cheese", "CookedChicken", "CookedSteak", "CookedChicken"])
	addSpells(["FireSpell", "FireSpell", "FireSpell", "GrabSpell", "FireSpell", "FreezeSpell"])

func addPotions(new_potions):
	for potion in new_potions:
		addPotion(potion)

func addPotion(new):
	potions.push_back(new)

func addFoods(new_foods):
	for food in new_foods:
		addFood(food)

func addFood(new):
	food.push_back(new)

func addSpells(new_spells):
	for spell in new_spells:
		addSpell(spell)

func addSpell(new):
	spells.push_back(new)

func walkable(x, y):
	return tilemap.walkable(x, y)
