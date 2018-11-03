extends Node

signal itemDropped(item)

var potions = []
var foods = []
var spells = []
var tilemap
var chosen_player
var player
var chosen_map
var characters = []
var environmentObjects = []
var placedItems = []
var TileSize = 128;

const PotionClasses = preload("res://Items/scripts/Potions.gd")
const FoodClasses = preload("res://Items/scripts/Foods.gd")
const SpellClasses = preload("res://Items/scripts/Spells.gd")
const Weapons = preload("res://Items/scripts/Weapons.gd")

func _ready():
	var instance = PotionClasses.HealthPotion.new()
	addPotions([instance, instance, instance])
	instance.pos = Vector2(4 * 128, 8 * 128)
	placeItem(instance)
	var instance = FoodClasses.CookedSteak.new()
	addFoods([instance, instance])
	instance.pos = Vector2(2 * 128, 2 * 128)
	placeItem(instance)
	var instance = SpellClasses.FireSpell.new()
	addSpells([instance, instance])
	instance.pos = Vector2(6 * 128, 12 * 128)
	placeItem(instance)

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
	return arrayAtPos(pos, characters)

func environmentObjectAtPos(pos):
	return arrayAtPos(pos, environmentObjects)

func arrayAtPos(pos, array):
	var collisions = []
	for i in range(array.size()):
		var other_orig_pos = Vector2(array[i].original_pos.x / GameData.TileSize, array[i].original_pos.y / GameData.TileSize)
		var other_target_pos = Vector2(array[i].target_pos.x / GameData.TileSize, array[i].target_pos.y / GameData.TileSize)
		if (other_orig_pos.x == pos.x and other_orig_pos.y == pos.y) or (other_target_pos.x == pos.x and other_target_pos.y == pos.y):
			collisions.append(array[i])
	return collisions

func pickedUp(item):
	placedItems.remove(placedItems.find(item))

func itemAtPos(pos):
	for item in placedItems:
		if (item.pos.x / 128 == round(pos.x) and item.pos.y / 128 == round(pos.y)):
			return item

func placeItem(item):
	GameData.placedItems.append(item)
	emit_signal("itemDropped", item)
	
func closestEnemy():
	var closestIndex
	var minDistance = -1
	for i in range(0, characters.size()):
		if characters[i] != player:
			var distance = player.original_pos.distance_squared_to(characters[i].original_pos)
			if minDistance == -1 || distance < minDistance:
				minDistance = distance
				closestIndex = i
	if minDistance > -1:
		return characters[closestIndex]
	else:
		return null

func walkable(x, y):
	return tilemap.walkable(x, y)

func reset():
	potions = []
	foods = []
	spells = []
	tilemap = null
	player = null
	environmentObjects = []
	characters = []
	placedItems = []