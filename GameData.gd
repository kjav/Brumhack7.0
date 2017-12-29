extends Node

var potions = []
var food = []
var spells = []
var tilemap
var player
var characters = []

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

func charactersAtPos(pos):
	var collisions = []
	for i in range(characters.size()):
		var other_orig_pos = Vector2(characters[i].original_pos.x / 128, characters[i].original_pos.y / 128)
		var other_target_pos = Vector2(characters[i].target_pos.x / 128, characters[i].target_pos.y / 128)
		if (other_orig_pos.x == pos.x and other_orig_pos.y == pos.y) or (other_target_pos.x == pos.x and other_target_pos.y == pos.y):
			collisions.append(characters[i])
	print(collisions)
	return collisions
	

func walkable(x, y):
	print("In walkable in GameData.gd")
	return tilemap.walkable(x, y)
