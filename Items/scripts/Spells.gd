class FireSpell extends "Item.gd":
	const texture = preload("res://assets/red_spell2.png")
	
	func _init():
		iconFilePath = "res://assets/red_spell2.png"
		description = "Shoot a fire ball at the closest enemy!"
		name = "Fire Spell"
	
	func onUse():
		GameData.closestEnemy().takeDamage(1)
		#animate a fireball
		GameData.spells.remove(GameData.spells.find(self))
		
	func pickup():
		#todo, needs to check if inventory is full first
		GameData.addSpells([self])
		.pickup()