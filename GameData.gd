extends Node

var potions = []
var foods = []
var spells = []
var tilemap
var player
var characters = []

const HealthPotion = preload("res://Items//HealthPotion.tscn")

func _ready():
	var instance = HealthPotion.instance()
	instance._ready()
	addPotions([instance, instance, instance])

func addPotions(new_potions):
	for potion in new_potions:
		potions.append(potion)

func addFoods(new_foods):
	for food in new_foods:
		foods.append(food)

func addSpells(new_spells):
	for spell in new_spells:
		spells.append(spell)

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
