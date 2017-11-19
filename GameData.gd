extends Node

var potions = []
var food = []
var spells = []

func _ready():
	addPotions("HealthPot")
	addPotions("StrengthPot")
	addPotions("StrengthPot")
	addPotions("HealthPot")
	addPotions("SpeedPot")
	addFood("Cheese")
	addFood("CookedChicken")
	addFood("CookedSteak")
	addFood("CookedChicken")
	addSpell("FireSpell")
	addSpell("FireSpell")
	addSpell("FireSpell")
	addSpell("GrabSpell")
	addSpell("FireSpell")
	addSpell("FreezeSpell")

func addPotions(new):
	potions.push_back(new)

func addFood(new):
	food.push_back(new)

func addSpell(new):
	spells.push_back(new)

