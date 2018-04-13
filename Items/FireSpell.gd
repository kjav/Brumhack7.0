extends "Item.gd"

const texture = preload("res://assets/red_potion2.png")

func _ready():
	iconFilePath = "res://assets/red_spell2.png"
	description = "Shoot a fire ball at the closest enemy!"
	name = "Fire Spell"

func onUse():
	var closest_enemy = GameData.closestEnemy()
	if closest_enemy:
		closest_enemy.takeDamage(1)
	#animate a fireball
	GameData.spells.remove(GameData.spells.find(self))